_maven_installed=false
command -v mvn
if [[ $? == 0 ]]; then
  _maven_has_installed=true
  echo "Found Maven"
else
  _maven_has_installed=false
  echo "Did not find Maven"
fi

function install_maven() {
	if [[ "$_java_has_installed" == false ]]; then
    $brew
	  $java
		if [[ $is_mac == 0 ]]; then
			brew install maven
		elif [[ $is_linux == 0 ]]; then
      apt-get -qq install -y maven
		else
			echo "Unknown Platform"
			exit 1
		fi
		_maven_has_installed=true
	else
		echo "Already installed Maven"
	fi
}

maven=install_maven
mvn=install_maven