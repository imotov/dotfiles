OS=$(uname)

if [[ $OS == "Darwin" ]]; then
	ANDROID_HOME=~/Library/Android/sdk; export ANDROID_HOME
    GROOVY_HOME=/usr/local/groovy; export GROOVY_HOME
    JAVA_HOME=$(/usr/libexec/java_home -v 1.8); export JAVA_HOME
	PATH=/usr/local/bin:~/bin:$GROOVY_HOME/bin:$ANDROID_HOME/platform-tools:$PATH; export PATH
	alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
fi
