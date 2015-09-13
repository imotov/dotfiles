OS=$(uname)

if [[ $OS == "Linux" ]]; then
  M2_HOME=~/Software/apache-maven-3.2.5; export M2_HOME
fi
