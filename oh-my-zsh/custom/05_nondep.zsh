# Update dotfiles
function dfup {
    cd ~/.dotfiles
    git fetch origin
    git merge --ff-only origin/master
    popd > /dev/null
}