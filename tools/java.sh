_java_installed=false
command -v java
if [[ $? == 0 ]]; then
  _java_has_installed=true
  echo "Found Java"
else
  _java_has_installed=false
  echo "Did not find Java"
fi

function install_java() {
	if [[ "$_java_has_installed" == false ]]; then
		if [[ $is_mac == 0 ]]; then
			$brew
			brew install java
		elif [[ $is_linux == 0 ]]; then
      apt-get -qq install -y default-jdk
		else
			echo "Unknown Platform"
			exit 1
		fi
		_java_has_installed=true
	else
		echo "Already installed Java"
	fi
}

java=install_java
