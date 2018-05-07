NAME=$(uname -n)

if [[ $NAME == "cicada.local" ]]; then
    ANDROID_HOME=~/Library/Android/sdk; export ANDROID_HOME
    JAVA_7_HOME=$(/usr/libexec/java_home -v 1.7); export JAVA_7_HOME
    launchctl setenv JAVA_7_HOME "$JAVA_7_HOME"
    JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA_8_HOME
    launchctl setenv JAVA_8_HOME "$JAVA_8_HOME"
    JAVA_9_HOME=$(/usr/libexec/java_home -v 9.0); export JAVA_9_HOME
    launchctl setenv JAVA_9_HOME "$JAVA_9_HOME"
    JAVA_10_HOME=$(/usr/libexec/java_home -v 10.0); export JAVA_10_HOME
    launchctl setenv JAVA_10_HOME "$JAVA_10_HOME"
    JAVA_HOME=$JAVA_9_HOME; export JAVA_HOME
    launchctl setenv JAVA_HOME "$JAVA_HOME"
    RUNTIME_JAVA_HOME=$JAVA_8_HOME; export RUNTIME_JAVA_HOME
    GOPATH=~/Projects/GoWork; export GOPATH
    PATH=/usr/local/bin:~/bin:$ANDROID_HOME/platform-tools:$PATH; export PATH
    NVM_DIR=~/.nvm; export NVM_DIR
    source $(brew --prefix nvm)/nvm.sh
    alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
    alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
fi
