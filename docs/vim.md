# VIM dotfiles
All vim configuration is in `vimrc`.

## Overview
* It uses **Vundle** plugin manager.
* There's a list of some other plugins. Some of them are `NERDTree`, `Ctrl-p`, `Airline`, `Ale`, and `Fugitive`.
* It also sets the theme to the **256 color Solarized Dark Theme**.
* It changes the default search tool to **ag** (the silver searcher) instead of ACK.

Some basic bindings are:

* `ctrl-p`: For fuzzy Search 
* `ctrl-n`: For NERDTree file explorer 
* `c-j` / `c-k`: Next/previous lintern error
*  `F8`: Toggle taglist
*  Go to tag:
  * `ctrl-]` jump to tag
  * `g<ctl>-]` jump to ambiguous tag
  * `ctrl-t` go back up to the tag stack
  * `:maketags`: Generate ctags
*  `c-f`: Format code 
* `alt-j` / `alt-k`: Move line up/down.

### Vim Lintern - Ale
> See documentation in https://github.com/w0rp/ale

Linterns:

  * **JS**: `sudo npm install -g standard`
  * **JSON**: `sudo npm install -g jsonlint`
  * **HTML**: `sudo npm install -g htmlhint`
  * **SASS**: `sudo npm install -g sass-lint`
  * **CSS**: `sudo npm install -g stylelint` 
  * **MARKDOWN**: `sudo pip install proselint`
  * **SQL**: `gem install sqlint`
  * **Python**: Basta con instalar flake9 `python3.6 -m pip install flake8` 
  * **YAML**: `sudo pip install yamllint`

Install all the linterns:
```bash
python3.6 -m pip install flake8
pip install proselint yamllint
sudo npm install -g standard jsonlint htmlhint sass-lint stylelint
gem install sqlint
```

Keybindings:

* `c-J` Next lintern error
* `c-K` Previous lintern error

## Vim tags - Basics (ctag) and a plugin (majutsushi/tagbar)
**Vim ctags default support**

Vim has already a ctag support.

If ctags is installed, there's a custom command `:Makectags` to generate them easily. It basically executes `ctags -R .` 

Once the `ctags`file is generated, you can use vim default ctag navigation commands:

  * `ctrl-]` jump to tag
  * `g<ctl>-]` jump to ambiguous tag
  * `ctrl-t` go back up to the tag stack

**majutsushi/tagbar**

The plugin ads a window with the browsable ctags.

You can:

  * `F8` Toggle the tag list. It's an alias for the `TlistToggle`

For:

  * `javascript`: It uses ramitos/jsctags that depends on Tern. The apfter-install.sh script istalls it.
  * `python`

## Vim tagbar

'majutsushi/tagbar'
