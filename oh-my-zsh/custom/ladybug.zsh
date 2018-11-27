NAME=$(uname -n)

if [[ $NAME == "ladybug" ]]; then
    # Fix zoom on high-res display
    QT_SCALE_FACTOR=2; export QT_SCALE_FACTOR
    # Setup go paths
    GOPATH=~/Projects/GoWork; export GOPATH
    PATH=$PATH:$GOPATH/bin; export PATH
fi
