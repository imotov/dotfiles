NAME=$(uname -n)

if [[ $NAME == "bumblebee" ]]; then
    # Fix zoom on high-res display
    QT_SCALE_FACTOR=2; export QT_SCALE_FACTOR
    alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
fi
