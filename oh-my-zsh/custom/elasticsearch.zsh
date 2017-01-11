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
    git fetch elasticsearch pull/$1/head:pr/$1
}
alias gnow='git commit --amend --date "`date`"'
# usage rempush: remote
# leafminer tests
alias leafpush='git push -f home $(current_branch); ssh home "cd /media/ramdisk; if ! test -e ${PWD##~/Projects/}; then git clone ~/Repo/${PWD##*/} ${PWD##~/Projects/}; fi; cd ${PWD##~/Projects/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch)"'
alias leaftest='leafpush; ssh home "NVM_DIR=/home/igor/.nvm; export NVM_DIR; . /home/igor/.nvm/nvm.sh; cd /media/ramdisk/${PWD##*/}; /home/igor/Software/gradle-2.13/bin/gradle clean check -Dtests.jvms=8"'
