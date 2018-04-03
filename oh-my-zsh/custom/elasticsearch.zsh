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
alias gnow='git commit --amend --date "`date`"'
# usage rempush: remote
# leafminer tests
alias leafpush='git push -f leafminer $(current_branch)'
