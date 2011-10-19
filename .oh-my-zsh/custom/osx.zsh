OS=$(uname)

if [[ $OS == "Darwin" ]]; then

    GROOVY_HOME=/usr/local/groovy; export GROOVY_HOME
    CLOJURE_HOME=/usr/local/clojure; export CLOJURE_HOME
    GRADLE_HOME=/usr/local/gradle; export GRADLE_HOME
    PATH=~/bin:$GROOVY_HOME/bin:$CLOJURE_HOME/script:$GRADLE_HOME/bin:$PATH; export PATH
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
