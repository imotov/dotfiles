# Elasticsearch specific settings
alias gffes='git merge --ff-only elasticsearch/$(current_branch)'
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfees='git fetch elasticsearch'
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
# flea tests
alias flearam='ssh flea.local "if ! test -e /Volumes/Ramdisk; then diskutil erasevolume HFS+ Ramdisk `hdiutil attach -nomount ram://16777216`; fi"'
alias fleapush='flearam; git push -f flea $(current_branch); ssh flea.local "cd /Volumes/Ramdisk; if ! test -e ${PWD##*/}; then git clone ~/Repo/${PWD##*/}; fi; cd ${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch)"'
alias fleatest='fleapush; ssh flea.local "cd /Volumes/Ramdisk/${PWD##*/}; JAVA_HOME=\$(/usr/libexec/java_home -v 1.8) PATH=/usr/local/bin:\$PATH gradle clean check"'
