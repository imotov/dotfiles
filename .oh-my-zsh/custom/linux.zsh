OS=$(uname)

if [[ $OS == "Linux" ]]; then
  M2_HOME=~/Software/apache-maven-3.2.5; export M2_HOME
  GRADLE_HOME=~/Software/gradle-2.13; export GRADLE_HOME
  PATH=~/bin:$GRADLE_HOME/bin:$PATH; export PATH
fi
