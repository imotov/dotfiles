OS=$(uname)

if [[ $OS == "Darwin" ]]; then
    ANDROID_HOME=~/Library/Android/sdk; export ANDROID_HOME
    GRADLE_HOME=~/Software/gradle-4.1; export GRADLE_HOME
    JAVA_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA_HOME
    PATH=/usr/local/bin:~/bin:$GRADLE_HOME/bin:$ANDROID_HOME/platform-tools:$PATH; export PATH
    NVM_DIR=~/.nvm; export NVM_DIR
    source $(brew --prefix nvm)/nvm.sh
    alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
fi
