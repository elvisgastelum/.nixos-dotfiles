# Keybindings

Source of truth for the new profile is `lua/dev/keybindings.lua`.

## Core

- Visual: `<A-j>`, `<A-k>`
- Insert: `jj`, `<D-BS>`, `<M-BS>`, `<A-j>`, `<A-k>`
- Splits/navigation: `<C-v>`, `<C-s>`, `<Leader>clh`, `<Leader>clv`, `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`
- Save/quit: `<Leader>s`, `<Leader>q`, `<C-q>`, `<C-S-q>`, `<Leader>wq`, `<Leader>ww`, `<Leader>wa`
- Resize/tabs: `<M-=>`, `<M-->`, `<M-+>`, `<Leader>=`, `<Leader>-`, `tN`, `tn`, `tp`, `xx`
- Format/LSP helpers: `fo`, `so`, `sp`, `hp`, `<Leader>a`, `<Leader>j`
- Telescope shortcuts: `<Leader>ff`, `<Leader>/`, `<Leader>fb`, `<Leader>fh`, `<Leader>fc`, `<Leader>fo`, `<Leader>fk`, `<Leader>fp`, `<Leader>fq`, `<Leader>fd`
- Oil shortcuts: `-`, `_`

## LSP

- Diagnostics: `dn`, `dp`, `do`
- Code action and completion: `df`, `<C-Space>`
- Navigation: `gd`, `gD`, `gs`, `gh`, `K`, `gr`
- Rename: `rn`

## VS Code mode

- Move lines: `<2206>`, `<A-k>`
- Multi cursor: `<C-d>`
- Rename/zen/quickfix: `rn`, `mz`, `df`
- Diagnostics: `dn`, `dp`

## Snacks

- Top level: `<leader><space>`, `<leader>,`, `<leader>?`, `<leader>:`, `<leader>n`, `<leader>e`
- Find: `<leader>fb`, `<leader>fc`, `<leader>ff`, `<leader>fg`, `<leader>fp`, `<leader>fr`
- Git: `<leader>gb`, `<leader>gl`, `<leader>gL`, `<leader>gs`, `<leader>gS`, `<leader>gd`, `<leader>gf`, `<leader>gB`, `<leader>gg`
- Search: `<leader>sb`, `<leader>sB`, `<leader>sg`, `<leader>sw`, `<leader>s"`, `<leader>s/`, `<leader>sa`, `<leader>sc`, `<leader>sC`, `<leader>sd`, `<leader>sD`, `<leader>sh`, `<leader>sH`, `<leader>si`, `<leader>sj`, `<leader>sk`, `<leader>sl`, `<leader>sm`, `<leader>sM`, `<leader>sp`, `<leader>sq`, `<leader>sR`, `<leader>su`, `<leader>ss`, `<leader>sS`
- LSP pickers: `gd`, `gD`, `gr`, `gI`, `gy`
- Other: `<leader>z`, `<leader>Z`, `<leader>.`, `<leader>S`, `<leader>bd`, `<leader>cR`, `<leader>un`, `<c-/>`, `<c-_>`, `]]`, `[[`, `<leader>N`, `<leader>uC`
- Toggle maps: `<leader>us`, `<leader>uw`, `<leader>uL`, `<leader>ud`, `<leader>ul`, `<leader>uc`, `<leader>uT`, `<leader>ub`, `<leader>uh`, `<leader>ug`, `<leader>uD`

## Oil

- Buffer: `g?`, `<CR>`, `<C-s>`, `<C-h>`, `<C-t>`, `<C-p>`, `<C-c>`, `<C-l>`, `-`, `_`, `` ` ``, `~`, `gs`, `gx`, `g.`, `g\`, `<Leader>ww`, `<Leader>q`, `Q`
- Global: `<Leader>O`, `<Leader>o`

## Telescope (inside picker)

- Default: `<c-q>`, `<c-b>`, `<c-f>`, `<c-j>` (disabled in insert)
- Git commits picker: `<M-d>`

## Completion / AI

- nvim-cmp: `<C-Space>`, `<C-u>`, `<C-d>`, `<C-y>`, `<CR>`, `<Tab>`, `<S-Tab>`
- supermaven: `<A-p>`, `<A-w>`, `<A-c>`
- copilot panel: `<CR>`, `[[`, `]]`, `gr`, open (`<M-CR>` in Neovide, `<D-CR>` otherwise)
- copilot suggestions:
  - Neovide: `<D-CR>`, `<D-[>`, `<D-]>`, `<C-]>`
  - Non-Neovide: `<A-CR>`, `[[`, `]]`, `}}`

## Plugins

- nx: `<leader>nx`
- harpoon: `<A-a>`, `<A-e>`, `<A-u>`, `<A-i>`, `<A-o>`, `<A-p>`
- zen-mode: `<A-z>`
- barbar: `<A-,>`, `<A-.>`, `<C-Tab>`, `<C-S-Tab>`, `<A-<>`, `<A->>`, `<A-1>`..`<A-0>`, `<A-p>`, `<A-c>`, `<C-p>`, `<Space>bb`, `<Space>bd`, `<Space>bl`, `<Space>bw`
- none-ls/null-ls: `<Leader>fo`, `<Leader>f`

## Disabled plugin mappings kept centralized

- mini.files: `<Leader>O`, `<Leader>o`
- neo-tree: `<bs>`, `.`, `H`, `f`, `D`, `/`, `<M-x>`, `[g`, `]g`
