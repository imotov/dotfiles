# Update dotfiles
function dfup {
    cd ~/.dotfiles
    git fetch origin
    ./gather
    git merge --ff-only origin/master
    ./push
    popd > /dev/null
}