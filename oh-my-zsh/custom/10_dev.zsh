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

function gnow {
  GIT_COMMITTER_DATE=`date '+%Y-%m-%d %H:%M:%S %z'`
  git commit --amend  --no-edit --date "$GIT_COMMITTER_DATE"
}

function gda {
  git_date=$([[ $OS == "Darwin" ]] && date -v-$1d '+%Y-%m-%d %H:%M:%S %z' || date --date="$1 day ago" '+%Y-%m-%d %H:%M:%S %z')
  GIT_COMMITTER_DATE="$git_date" git commit --amend  --no-edit --date "$git_date"
}

# ======= Poetry shortcuts ========

function po {
  poetry "$@"
}

function poi {
  po install "$@"
}

function poid {
  po install --only=dev "$@"
}

function poind {
  po install --without=dev "$@"
}

function pon {
  po new "$1" && \
  cd "$1" && \
  poi && \
  curl -sSfOL https://raw.githubusercontent.com/python-poetry/poetry/main/.gitignore && \
  git init
}

function pont {
  pon "$1" && \
  poad pytest && \
  mkdir .vscode && \
  if [[ -n $(command -v jq) ]]; then echo '{"python.testing.pytestArgs": ["-vv","-s"],"python.testing.pytestEnabled": true}' | jq >  .vscode/settings.json; fi
}

function pontc {
  pont "$1" && code .
}

function ponc {
  pon "$1" && code .
}

function poa {
  po add "$@"
}

function poad {
  poa --group dev "$@"
}

function pos {
  po show "$@"
}

function posd {
  pos --only=dev "$@"
}

function posnd {
  pos --without=dev "$@"
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
alias cddf='cd ~/.dotfiles'
alias cdsb='cd ~/Sandbox'
alias cdp='cd ~/Projects'
alias cdpi='cd ~/Projects/imotov'
alias cdpa='cd ~/Projects/akaula'
alias bw='aws --endpoint-url http://black-widow.home.motovs.org:9000 s3'
