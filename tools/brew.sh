_brew_has_installed=false
command -v brew
if [[ $? == 0 ]]; then
  _brew_has_installed=true
  echo "Found Brew"
else
  _brew_has_installed=false
  echo "Did not find Brew"
fi

function install_mac_brew() {
	command -v brew
	if [[ $? != 0 ]] ; then
		# Install Homebrew
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		brew update
	fi
	
	echo "**Please install Command Line Tools"
	# Add Command Line Tools
	xcode-select --install
}

function install_brew() {
	if [[ "$_brew_has_installed" == false ]]; then
		echo "-- Installing Brew --"
		if [[ $is_mac == 0 ]]; then
			call install_mac_brew
		elif [[ $is_linux == 0 ]]; then
			# Do something under GNU/Linux platform
			# TODO Add brew for linux
			echo "Nothing to do"
		else
			echo "Unknown Platform"
			exit 1
		fi
		_brew_has_installed=true
	else
		echo "Already installed Brew"
	fi
}

brew=install_brew

