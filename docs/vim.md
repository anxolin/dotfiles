# VIM dotfiles

All vim configuration is in `vimrc`.

## Overview

- It uses **Vundle** plugin manager.
- There's a list of some other plugins. Some of them are `NERDTree`, `Ctrl-p`, `Airline`, `Ale`, and `Fugitive`.
- It also sets the theme to the **256 color Solarized Dark Theme**.
- It changes the default search tool to **ag** (the silver searcher) instead of ACK.

Some basic bindings are:

- `ctrl-p`: For fuzzy Search
- `ctrl-n`: For NERDTree file explorer
- `c-j` / `c-k`: Next/previous lintern error
- `F8`: Toggle taglist
- `\<searcg_text>` or `:Ag <search_text>` for searching using **ag**.
- Go to definition, usages, and rename
  - `\d`: Go to definition
  - `c-o`: Go back to previous position
  - `c-i`: Go forward to next position
  - `\n`: Find usages
  - `\r`: Rename
- Autocomplete and documentation:
  - `c-space`: Autocomplete
  - `K`: Documentation
- Go to tag:
  - `ctrl-]` jump to tag
  - `g<ctl>-]` jump to ambiguous tag
  - `ctrl-t` go back up to the tag stack
  - `:maketags`: Generate ctags
- `c-f`: Format code
- `alt-j` / `alt-k`: Move line up/down.
- **Quick fix** and **Location List**:
  - `cw[indow]`: Open the quickfix if there's errors. If there's not, it hides the window if open.
  - `lw[indow]`: Same as `cw[indow]` but for the location list.
  - `cclose`: Close the quickfix (example: AsyncTask)
  - `lclose`: Close the location list (example: Lintern)
- Easy Motion:
  - `<leader>w` Word motion. Hihlight's the first letter of the word
  - `<leader>e` Highlight the end of the word
  - `<leader>s` Highlight searching a letter
  - `<leader>/` Highlight searching N-letters
  - `<leader>j` Highlight lines up
  - `<leader>k` Highlight lines up
- Async run: Run something asyncronously and show the result in the
  - `:AsyncRun <command>`: Runs command in the quickfix window

### Vim Lintern - Ale

> See documentation in https://github.com/w0rp/ale

Linterns:

- **JS**: `sudo npm install -g standard`
- **JSON**: `sudo npm install -g jsonlint`
- **HTML**: `sudo npm install -g htmlhint`
- **SASS**: `sudo npm install -g sass-lint`
- **CSS**: `sudo npm install -g stylelint`
- **MARKDOWN**: `sudo pip install proselint`
- **SQL**: `gem install sqlint`
- **Python**: Basta con instalar flake9 `python3 -m pip install flake8`
- **YAML**: `sudo pip install yamllint`

Install all the linterns:

```bash
python3 -m pip install flake8
pip install proselint yamllint
sudo npm install -g standard jsonlint htmlhint sass-lint stylelint
gem install sqlint
```

Keybindings:

- `c-J` Next lintern error
- `c-K` Previous lintern error

## Vim autocomplete, go to definition, view usages and refactor

> I haven't tried youcompletme yet, but I've used jedi vim plugin and It works great

It uses
The main mappings are:

- Autocomplete and documentation:
  - `c-space`: Autocomplete
  - `K`: Documentation
- Go to definition, usages, and rename
  - `\d`: Go to definition
  - `c-o`: Go back to previous position
  - `c-i`: Go forward to next position
  - `\n`: Find usages
  - `\r`: Rename

It uses several plugins:

- **python**: `davidhalter/jedi-vim` Autocomplete, rename, go to definition and find usages
- **javascript**:
  - **Tern**: `ternjs/tern_for_vim`:
    - **TernDef**: Jump to the definition of the thing under the cursor.
    - **TernDoc**: Look up the documentation of something.
    - **TernType**: Find the type of the thing under the cursor.
    - **TernRefs**: Show all references to the variable or property under the cursor.
    - **TernRename**: Rename the variable under the cursor.
  - youcompleteme: `Valloric/YouCompleteMe` (it's not just for Javascript)

## Search with Ag

Ag is configured:

- Instead of **ack** and **grep**.
- Mapped to `:Ag<search_text>` command and `\<search_text>`.
- It's used by **ctrl-p** for fuzzy-search.
-

## Async Run

More info in: https://github.com/skywind3000/asyncrun.vim

- Async run: Run something asyncronously and show the result in the
  - `:AsyncRun <command>`: Runs command in the quickfix window
    - i.e. .`:AsyncRun gcc % -o %<`. run gcc in the background and output to the quickfix window in realtime. Macro '%' stands for filename and '%<' represents filename without extension.

## TODO: leader

https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

## Vim tags - Basics (ctag) and a plugin (majutsushi/tagbar)

**Vim ctags default support**

Vim has already a ctag support.

If ctags is installed, there's a custom command `:Makectags` to generate them easily. It basically executes `ctags -R .`

Once the `ctags`file is generated, you can use vim default ctag navigation commands:

- `ctrl-]` jump to tag
- `g<ctl>-]` jump to ambiguous tag
- `ctrl-t` go back up to the tag stack

**majutsushi/tagbar**

The plugin ads a window with the browsable ctags.

You can:

- `F8` Toggle the tag list. It's an alias for the `TlistToggle`

For:

- `javascript`: It uses ramitos/jsctags that depends on Tern. The apfter-install.sh script istalls it.
- `python`

## Vim tagbar

'majutsushi/tagbar'

## Expand selection: terryma/vim-expand-region

Remapped https://github.com/terryma/vim-expand-region to :

- `v`: expand the visual selection
- `c-v`: shrink it
