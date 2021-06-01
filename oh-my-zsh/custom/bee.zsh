OS=$(uname)

if [[ $OS == "Darwin" ]]; then
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
  alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
  alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"

  JAVA11_HOME=$(/usr/libexec/java_home -v 11.0); export JAVA11_HOME
  launchctl setenv JAVA11_HOME "$JAVA11_HOME"

  JAVA16_HOME=$(/usr/libexec/java_home -v 16.0); export JAVA16_HOME
  launchctl setenv JAVA16_HOME "$JAVA16_HOME"

  JAVA_HOME=$JAVA16_HOME; export JAVA_HOME
  launchctl setenv JAVA_HOME "$JAVA_HOME"
fi
