OS=$(uname)

if [[ $OS == "Darwin" ]]; then

    GROOVY_HOME=/usr/local/groovy; export GROOVY_HOME
    GRADLE_HOME=/usr/local/gradle; export GRADLE_HOME
    PATH=~/bin:$GROOVY_HOME/bin:$GRADLE_HOME/bin:$PATH; export PATH
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
