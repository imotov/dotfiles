# Github specific settings
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfeor='git fetch origin'
alias gffqw='git merge --ff-only quickwit-oss/$(current_branch)'
alias gfeqw='git fetch quickwit-oss'
alias cds='cd ~/Software'
alias cdd='cd ~/Downloads'
function gfe {
	git fetch $1
}
function gff {
	git merge --ff-only $1/$(current_branch)
}

alias gnow='git commit --amend --date "`date`"'

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
