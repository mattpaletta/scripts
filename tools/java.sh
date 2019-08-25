_java_installed=false
which -s java
if [[ $? == 0 ]]; then
  _java_has_installed=true
  echo "Found Java"
else
  _java_has_installed=false
  echo "Did not find Java"
fi

function install_brew() {
	if [[ "$_java_has_installed" == false ]]; then
		if [[ is_mac ]]; then
			$brew
			brew install java
		elif [[ is_linux ]]; then
      apt-get install -y default-jdk
		else
			echo "Unknown Platform"
			exit 1
		fi
		$_java_has_installed=true
	else
		echo "Already installed Java"
	fi
}

java=install_java
