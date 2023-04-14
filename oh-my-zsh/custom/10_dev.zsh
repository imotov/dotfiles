# ========= Github specific settings ========= 
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfeor='git fetch origin'
alias gffim='git merge --ff-only imotov/$(current_branch)'
alias gffta='git merge --ff-only tarantula/$(current_branch)'
alias gfeim='git fetch imotov'
alias gfeta='git fetch tarantula'
alias gimpush='git push imotov "$(git_current_branch)"'
alias gtapush='git push tarantula "$(git_current_branch)"'

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

# Git create ssh remote 
function gcsr {
  if [[ "$#" -ne 2 ]]; then
    print >&2 "Usage: $0 server path"
    return
  fi
  server="$1"
  git_path="$2"
  project=$(basename $(pwd))
  repository="${project}.git"
  user=$(whoami)
  ssh $server "set -e; cd $git_path; mkdir $repository; cd $repository; git init --initial-branch=main --bare"
  git remote add $server ${user}@$server:${git_path}/${repository}
}

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
alias cdsb='cd ~/Sandbox'
alias cdp='cd ~/Projects'
alias cdpi='cd ~/Projects/imotov'
alias cdpq='cd ~/Projects/quickwit-oss'
alias bw='aws --endpoint-url http://black-widow.home.motovs.org:9000 s3'
