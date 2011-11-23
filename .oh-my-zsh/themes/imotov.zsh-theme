local user='%{$fg[grey]%}%n@%{$fg[grey]%}%m%{$reset_color%}'
local pwd='%{$fg[green]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)'


# Handle dumb (emacs) terminals with no color
if [ $TERM = "dumb" ]
    then PROMPT='%~ $ '
    else PROMPT="${user}:${pwd}${git_branch}› "
fi

ZSH_THEME_GIT_PROMPT_PREFIX="‹%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"