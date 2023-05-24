# ========= Github specific settings ========= 
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfeor='git fetch origin'
alias gffim='git merge --ff-only imotov/$(current_branch)'
alias gfflm='git merge --ff-only leafminer/$(current_branch)'
alias gfeim='git fetch imotov'
alias gfelm='git fetch leafminer'
alias gimpush='git push imotov "$(git_current_branch)"'
alias glmpush='git push leafminer "$(git_current_branch)"'

function gfe {
	git fetch $1
}
function gff {
	git merge --ff-only $1/$(current_branch)
}

# fetch PR from remote 
function gprf {
  git fetch origin pull/$1/head:pr/$1
}

# fetch PR and squash merge it into master
function gprm {
  gprf $1 && git merge --squash pr/$1
}

# clean after PR review
function gprc {
  git branch -D pr/$1 && git reset --hard HEAD
}

alias gnow='git commit --amend --date "`date`"'

# ========= Misc commands ========= 

function shuffle {
  for i; do
    echo $i
  done \
  | awk 'BEGIN{srand()}{print rand(), $0}' \
  | sort -n -k 1 \
  | awk 'sub(/^[0-9.]+ ([a-zA-Z0-9]+)$/,$2)' \
  | tr '\n' ' '
	echo
}

# Working directories
alias cds='cd ~/Software'
alias cdd='cd ~/Downloads'
alias cddf='cd ~/.dotfiles'
alias cdsb='cd ~/Sandbox'
alias cdp='cd ~/Projects'
alias cdpi='cd ~/Projects/imotov'
alias bw='aws --endpoint-url http://black-widow.home.motovs.org:9000 s3'

# Quickwit specific
alias cdpq='cd ~/Projects/quickwit-oss'
alias cdpqq='cd ~/Projects/quickwit-oss/quickwit'
alias qwdu='pushd ~/Projects/quickwit-oss/quickwit; make docker-compose-up; popd'
alias qwdd='pushd ~/Projects/quickwit-oss/quickwit; make docker-compose-down; popd'
alias qwrmp='pushd ~/Projects/quickwit-oss/quickwit; make -k docker-compose-down rm-postgres docker-compose-up; popd'
export QW_DISABLE_TELEMETRY=1
