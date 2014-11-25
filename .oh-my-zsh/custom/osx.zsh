OS=$(uname)

if [[ $OS == "Darwin" ]]; then
    GROOVY_HOME=/usr/local/groovy; export GROOVY_HOME
    JAVA_HOME=$(/usr/libexec/java_home -v 1.7); export JAVA_HOME
	PATH=/usr/local/bin:~/bin:$GROOVY_HOME/bin:$PATH; export PATH
	alias callhome="ssh -C -N -2 -v -D 8080 home"
fi
