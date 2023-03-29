# Update dotfiles
function dfup {
    olddir=$(pwd)
    cd ~/.dotfiles
    git fetch origin
    ./gather
    git merge --ff-only origin/master
    ./push
    cd $olddir
}