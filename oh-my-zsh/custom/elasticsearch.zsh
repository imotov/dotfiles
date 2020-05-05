# Elasticsearch specific settings
alias gffes='git merge --ff-only elastic/$(current_branch)'
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfees='git fetch elastic'
alias gfeor='git fetch origin'
function gfe {
	git fetch $1
}
function gff {
	git merge --ff-only $1/$(current_branch)
}
function gpr {
    git fetch elastic pull/$1/head:pr/$1
}
# fetch PR and squash merge it into master
function gprm {
	gpr $1 && git merge --squash pr/$1
}
# clean after PR review
function gprc {
	git branch -D pr/$1 && git reset --hard HEAD
}

alias gnow='git commit --amend --date "`date`"'
# usage rempush: remote
# leafminer tests
# alias leafpush='git push -f leafminer $(current_branch)'
# alias homepush='git push -f home $(current_branch); ssh home "cd /media/ramdisk; if ! test -e ${PWD##~/Projects/*/}; then git clone ~/Repo/${PWD##*/} ${PWD##~/Projects/*/}; fi; cd ${PWD##~/Projects/*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch)"'
