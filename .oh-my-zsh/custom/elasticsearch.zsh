# Elasticsearch specific settings
alias gffes='git merge --ff-only elasticsearch/$(current_branch)'
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfees='git fetch elasticsearch'
alias gfeor='git fetch origin'
function gpr { 
    git fetch elasticsearch pull/$1/head:pr/$1
}
alias estest="ES_TEST_LOCAL=true mvn -Dtests.jvms=4 clean test"
alias gnow='git commit --amend --date "`date`"'
alias fleatest='git push -f flea $(current_branch); ssh flea.local "cd ~/Builds/${PWD##*/}; git fetch origin; git checkout $(current_branch); git reset --hard origin/$(current_branch); JAVA_HOME=\$(/usr/libexec/java_home -v 1.7) mvn clean test"'
