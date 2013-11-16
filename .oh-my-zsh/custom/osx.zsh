OS=$(uname)

if [[ $OS == "Darwin" ]]; then
    GROOVY_HOME=/usr/local/groovy; export GROOVY_HOME
	M2_HOME=/usr/local/apache-maven-3.1.1; export M2_HOME
	MAVEN_OPTS="-Xms256m -Xmx512m"; export MAVEN_OPTS
    JAVA_HOME=$(/usr/libexec/java_home); export JAVA_HOME
    PATH=/opt/local/bin:/opt/local/sbin:~/bin:$GROOVY_HOME/bin:$M2_HOME/bin:$PATH; export PATH
fi
