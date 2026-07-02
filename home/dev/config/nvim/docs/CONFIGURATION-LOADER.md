# Configuration Loader

This config supports multiple profiles under `lua/{config-name}`.

Every profile must expose:

```lua
local M = {}

function M.setup()
  -- load your config
end

return M
```

## Startup loading

`init.lua` should call:

```lua
require('configuration-loader').setup {
  profile = 'dev',
}
```

- `profile` is the default profile.
- If a saved profile exists, it overrides this default.

## Command

Use `:ConfigSet <profile>` to select what will load on the next Neovim start.

`:ConfigSelect <profile>` is an alias of `:ConfigSet`.

Use `:ConfigStatus` to show the active profile now and the profile selected for next startup.

- Completion is dynamic and comes from folders matching `lua/*/init.lua`.
- `lua/configuration-loader` is excluded from candidates.
- Restart Neovim after switching for a clean reload.

## Persistence

The selected profile is stored in:

`vim.fn.stdpath('state') .. '/selected-config-profile'`

## Type inference

The loader includes Lua annotations for `lua_ls`:

- `ConfigurationLoaderSetupOptions`
- `ConfigurationProfile` (`'dev' | 'stable'`)

So editors can infer:

```lua
require('configuration-loader').setup({
  profile = 'dev',
})
```

## Runtime help

This config ships Vim help at `doc/config-loader.txt`.

- Helptags are auto-generated during `configuration-loader.setup()`.
- Open help with `:help config-loader`.
