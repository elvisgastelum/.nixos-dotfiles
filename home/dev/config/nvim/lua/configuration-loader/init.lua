local M = {}

---@alias ConfigurationProfile 'dev'|'stable'

---@class ConfigurationLoaderSetupOptions
---@field profile? ConfigurationProfile|string

local STATE_FILE = vim.fn.stdpath('state') .. '/selected-config-profile'
local LUA_ROOT = vim.fn.stdpath('config') .. '/lua'
local LOADER_NAME = 'configuration-loader'
local DOC_ROOT = vim.fn.stdpath('config') .. '/doc'
local ACTIVE_PROFILE = nil

---@param value string
---@return string
local function trim(value)
	return (value:gsub('^%s*(.-)%s*$', '%1'))
end

---@return string[]
local function get_available_profiles()
	local init_files = vim.fn.globpath(LUA_ROOT, '*/init.lua', 0, 1)
	---@type string[]
	local profiles = {}
	---@type table<string, boolean>
	local seen = {}

	for _, path in ipairs(init_files) do
		local name = vim.fn.fnamemodify(path, ':h:t')
		if name ~= LOADER_NAME and not seen[name] then
			seen[name] = true
			table.insert(profiles, name)
		end
	end

	table.sort(profiles)
	return profiles
end

---@param profile? string
---@return boolean is_valid
local function is_valid_profile(profile)
	if profile == nil then
		return false
	end

	for _, value in ipairs(get_available_profiles()) do
		if value == profile then
			return true
		end
	end

	return false
end

---@param profile string
---@return boolean
local function save_profile(profile)
	if not is_valid_profile(profile) then
		return false
	end

	local state_dir = vim.fn.fnamemodify(STATE_FILE, ':h')
	vim.fn.mkdir(state_dir, 'p')
	vim.fn.writefile({ profile }, STATE_FILE)

	return true
end

---@return string|nil
local function read_saved_profile()
	if vim.fn.filereadable(STATE_FILE) == 0 then
		return nil
	end

	local lines = vim.fn.readfile(STATE_FILE)
	if #lines == 0 then
		return nil
	end

	local saved = trim(lines[1])
	if is_valid_profile(saved) then
		return saved
	end

	return nil
end

---@param default_profile? string
---@return string
local function resolve_profile(default_profile)
	local saved_profile = read_saved_profile()
	if is_valid_profile(saved_profile) then
		return saved_profile
	end

	if is_valid_profile(default_profile) then
		return default_profile
	end

	return 'dev'
end

---@param opts ConfigurationLoaderSetupOptions
local function set_config_command_handler(opts)
	local profile = opts.args
	local available = get_available_profiles()

	if not is_valid_profile(profile) then
		vim.notify('Invalid profile: ' .. profile .. '. Use ' .. table.concat(available, ', ') .. '.', vim.log.levels.ERROR)
		return
	end

	save_profile(profile)
	vim.notify('Configuration profile "' .. profile .. '" saved. Restart Neovim to load it cleanly.', vim.log.levels.INFO)
end

local function create_set_config_commands()
	if vim.fn.exists(':LoadConfig') == 2 then
		vim.api.nvim_del_user_command('LoadConfig')
	end

	if vim.fn.exists(':ConfigSet') == 2 then
		vim.api.nvim_del_user_command('ConfigSet')
	end

	if vim.fn.exists(':ConfigSelect') == 2 then
		vim.api.nvim_del_user_command('ConfigSelect')
	end

	local options = {
		desc = 'Persist config profile for next startup',
		nargs = 1,
		complete = function()
			return get_available_profiles()
		end,
	}

	vim.api.nvim_create_user_command('ConfigSet', set_config_command_handler, options)
	vim.api.nvim_create_user_command('ConfigSelect', set_config_command_handler, options)
end

local function create_config_status_command()
	if vim.fn.exists(':ConfigStatus') == 2 then
		vim.api.nvim_del_user_command('ConfigStatus')
	end

	vim.api.nvim_create_user_command('ConfigStatus', function()
		local selected_for_next = read_saved_profile() or ACTIVE_PROFILE or 'unknown'
		local active_now = ACTIVE_PROFILE or 'unknown'

		vim.notify('Active: ' .. active_now .. ' | Next start: ' .. selected_for_next, vim.log.levels.INFO)
	end, {
		desc = 'Show active config and next startup config',
		nargs = 0,
	})
end

local function ensure_helptags()
	if vim.fn.isdirectory(DOC_ROOT) == 0 then
		return
	end

	local ok = pcall(vim.cmd, 'silent! helptags ' .. vim.fn.fnameescape(DOC_ROOT))
	if not ok then
		vim.notify('Unable to generate helptags for ' .. DOC_ROOT, vim.log.levels.WARN)
	end
end

---@param opts? ConfigurationLoaderSetupOptions
function M.setup(opts)
	opts = opts or {}

	ensure_helptags()
	create_set_config_commands()
	create_config_status_command()

	local profile = resolve_profile(opts.profile)
	ACTIVE_PROFILE = profile
	require(profile).setup()
end

return M
