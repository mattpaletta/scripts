_cpp_has_installed=false
command -v gcc
if [[ $? == 0 ]]; then
  _cpp_has_installed=true
  echo "Found cpp"
else
  _cpp_has_installed=false
  echo "Did not find cpp"
fi

function install_cpp() {
	if [[ "$_cpp_has_installed" == false ]]; then
		echo "-- Installing c++"
		echo "DOING NOTHING YET"

		if [[ $is_mac == 0 ]]; then
			echo "DOING NOTHING YET"
		elif [[ $is_linux == 0 ]]; then
			echo "DOING NOTHING YET"
		else
			echo "Unknown Platform"
			exit 1
		fi
		_cpp_has_installed=true
	else
		echo "Already installed cpp"
	fi
}

cpp=install_cpp

