# lilguys.nvim

Sometimes you just need to add a lil guy to the line!

![lilguys](https://s4.gifyu.com/images/bLJaL.gif)

This plugin provides you with a keybind to easily toggle a symbol like `|>` before the content of a line.

I made it because typing `|>` on my keyboard is moderately inconvenient, but also because I've never made a real plugin before.

## ✨ Features

- Toggle lil guy (`|>`) at the start of the line (supports multi-line selections and motion counts)
- Insert lil guy at cursor (supports `.` repetition)
- Filetype-sensitive activation
- Configurable keymaps and symbol

## 📦 Installation

Requres Neovim `0.7.0`

### Using `lazy.nvim`

```lua
{
  'stunwin/lilguys.nvim',
  config = function()
    require('lilguys').setup()
  end
}
```

### Using `packer.nvim`

```lua
use {
  'stunwin/lilguys.nvim',
  config = function()
    require('lilguys').setup()
  end
}
```

## ⚙️ Configuration

- Default keybind to toggle a lil guy at the start of the line is `<leader>.`
- Default keybind to insert a lil guy at your cursor is  `<leader>,`

```lua
opts = {
  keybind = '<leader>.',  -- toggles a lil guy in at the front of the line. Respects whitespace.
  insert_keybind = '<leader>,',  -- adds a lil guy and a space right before your curor
  symbol = '|>',  -- want a different lil guy? put him here!
  filetypes = { "gleam", "elm", "elixir", "fsharp", "ocaml", "reason" }, -- your lil guy probably only works in certain files. make sure they're here
  auto_insert = true, -- if you use the main keybind on a new, empty line, this will kick you straight into insert mode... or not!
}
```

## todo

- [x] Add support for motion-count iteration
- [ ] Set per-filetype lil guys
- [ ] Three-way toggle between start of line, at-cursor, and off states
- [ ] Support for massive concurrency and cloud deployment
- [ ] finish this and probably get back to real work

## credits

I got the idea for this from [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)'s checkboxes

I would have no idea what I'm doing without [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
