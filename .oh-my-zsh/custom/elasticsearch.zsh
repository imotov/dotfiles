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
alias fleatest='git push -f flea $(current_branch); ssh flea.local "cd ~/Builds/${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch); JAVA_HOME=\$(/usr/libexec/java_home -v 1.8) PATH=/usr/local/bin:\$PATH gradle clean check"'
alias fleapush='git push -f flea $(current_branch); ssh flea.local "cd ~/Builds/${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch)"'
alias flearemtest='git push -f flearemote $(current_branch); ssh flea.homedns.org -p 22422 "cd ~/Builds/${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch); JAVA_HOME=\$(/usr/libexec/java_home -v 1.8) PATH=/usr/local/bin:\$PATH gradle clean check"'
alias flearempush='git push -f flearemote $(current_branch); ssh flea.homedns.org -p 22422 "cd ~/Builds/${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch)"'
