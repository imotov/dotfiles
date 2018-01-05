NAME=$(uname -n)

if [[ $NAME == "cicada.local" ]]; then
    ANDROID_HOME=~/Library/Android/sdk; export ANDROID_HOME
    JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA_8_HOME
    JAVA_HOME=$(/usr/libexec/java_home -v 9.0); export JAVA_HOME
    GOPATH=~/Projects/GoWork; export GOPATH
    PATH=/usr/local/bin:~/bin:$ANDROID_HOME/platform-tools:$PATH; export PATH
    NVM_DIR=~/.nvm; export NVM_DIR
    source $(brew --prefix nvm)/nvm.sh
    alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
fi
