NAME=$(uname -n)

if [[ $NAME == "bumblebee" ]]; then
    # Fix zoom on high-res display
    QT_SCALE_FACTOR=2; export QT_SCALE_FACTOR
    alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
    alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
    alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
fi
