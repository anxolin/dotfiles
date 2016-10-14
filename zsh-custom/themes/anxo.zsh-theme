# based in robbyrussell theme
# Added hostname

local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%}➜ )"
PROMPT='%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)%{$fg[yellow]%}➜%{$reset_color%}  '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
