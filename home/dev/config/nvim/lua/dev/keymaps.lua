local utils = require "dev.utils"
local keybindings = require "dev.keybindings"

local format = utils.custom_format.format
local typescript_organize_imports = utils.typescript.organize_imports

keybindings.apply_core_keymaps(utils, format, typescript_organize_imports)
