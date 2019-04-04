NAME=$(uname -n)

if [[ $NAME == "ladybug" ]]; then
    # Setup go paths
    GOPATH=~/Projects/GoWork; export GOPATH
    PATH=$PATH:$GOPATH/bin; export PATH
fi
