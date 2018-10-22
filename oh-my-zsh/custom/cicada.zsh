OS=$(uname)

if [[ $OS == "Darwin" ]]; then
    ANDROID_HOME=~/Library/Android/sdk; export ANDROID_HOME
    JAVA7_HOME=$(/usr/libexec/java_home -v 1.7); export JAVA7_HOME
    launchctl setenv JAVA7_HOME "$JAVA7_HOME"
    JAVA8_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA8_HOME
    launchctl setenv JAVA8_HOME "$JAVA8_HOME"
    JAVA9_HOME=$(/usr/libexec/java_home -v 9.0); export JAVA9_HOME
    launchctl setenv JAVA9_HOME "$JAVA9_HOME"
    JAVA10_HOME=$(/usr/libexec/java_home -v 10.0); export JAVA10_HOME
    launchctl setenv JAVA10_HOME "$JAVA10_HOME"
    JAVA11_HOME=$(/usr/libexec/java_home -v 11.0); export JAVA11_HOME
    launchctl setenv JAVA11_HOME "$JAVA11_HOME"
    JAVA_HOME=$JAVA11_HOME; export JAVA_HOME
    launchctl setenv JAVA_HOME "$JAVA_HOME"
    RUNTIME_JAVA_HOME=$JAVA8_HOME; export RUNTIME_JAVA_HOME
    GOPATH=~/Projects/GoWork; export GOPATH
    PATH=/usr/local/bin:~/bin:$ANDROID_HOME/platform-tools:$GOPATH/bin:$PATH; export PATH
    NVM_DIR=~/.nvm; export NVM_DIR
    source $(brew --prefix nvm)/nvm.sh
    alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
    alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
fi
