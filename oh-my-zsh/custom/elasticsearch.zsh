# Elasticsearch specific settings
alias gffes='git merge --ff-only elastic/$(current_branch)'
alias gffor='git merge --ff-only origin/$(current_branch)'
alias gfees='git fetch elastic'
alias gfeor='git fetch origin'
alias cd7='cd ~/Projects/elastic/7.x/elasticsearch'
alias cd8='cd ~/Projects/elastic/8.x/elasticsearch'
alias cds='cd ~/Software'
alias cdd='cd ~/Downloads'
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
function rampush {
	cur_dir=${PWD}
	cur_proj=${PWD##*/}
	cur_branch=$(current_branch)
	cd /mnt/ramdisk
	if ! test -e ${cur_proj}; then
		git clone ${cur_dir}
	fi
	cd ${cur_proj}
	git fetch origin
	git reset --hard origin/${cur_branch}
	cd ${cur_dir}
}
# run common PR checks
function prcheck {
	./gradlew --parallel --max-workers=14 checkPart1 checkPart2 bwcTestSnapshots
}
clean_branches() {
  branches=()
  eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/)"
  for branch in "${branches[@]}"; do
    short_name=${branch#"refs/heads/"}
    if [[ ! $short_name =~ '^[0-9]+\.([0-9]|x)[0-9]*|master$'  ]]; then

      echo ">>>> " $short_name
      git --no-pager log "$branch" -1
      read -q "yn?Delete this branch? "
      echo
      case $yn in
      [Nn]* )
          echo
          echo keeping
          echo
          ;;
      [Yy]* )
          echo
          git branch -D $short_name
          echo
          ;;
      esac
    fi
  done
}
function esrun {
	cur_dir=${PWD}
	data_dir="$(dirname "${cur_dir}")/data"
	./gradlew run -Drun.license_type=trial --data-dir="${data_dir}"
}
