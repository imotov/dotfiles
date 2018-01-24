NAME=$(uname -n)

if [[ $NAME == "gejigeji.local" ]]; then
    JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA_8_HOME
    JAVA_9_HOME=$(/usr/libexec/java_home -v 9.0); export JAVA_9_HOME
    JAVA_HOME=$JAVA_9_HOME; export JAVA_HOME
    RUNTIME_JAVA_HOME=$JAVA_8_HOME; export RUNTIME_JAVA_HOME
    PATH=/usr/local/bin:~/bin:$PATH; export PATH
    NVM_DIR=~/.nvm; export NVM_DIR
    source $(brew --prefix nvm)/nvm.sh
    alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
fi
