local user=''
local connection=''
local pwd='%{$fg[green]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)'

if [[ $(uname -n) == "leafminer" ]]; then
  user='%{$fg_bold[green]%}%n@%m%{$reset_color%}'
elif [[ ${$(uname -n)%%.*} == "bee"  ]]; then
  user='%{$fg_bold[blue]%}%n@%m%{$reset_color%}'
else
  user='%{$fg_bold[red]%}%n@%m%{$reset_color%}'
fi

if [[ -v SSH_CONNECTION ]]; then
  connection="%{$fg[red]%}⚡%{$reset_color%}"
 else
  connection=""
 fi


# Handle dumb (emacs) terminals with no color
if [ $TERM = "dumb" ]
    then PROMPT='%~ $ '
    else PROMPT="${connection}${user}:${pwd}${git_branch}❯ "
fi

ZSH_THEME_GIT_PROMPT_PREFIX="❮%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⭒%{$reset_color%}"

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning
