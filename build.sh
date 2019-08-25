# Cat all the tools/script files together
# Append a build script, write it into install.sh

echo "-- Creating output file"
INSTALL_FILE="./install.sh"
rm -f $INSTALL_FILE
touch $INSTALL_FILE
echo "-- Created install file"

echo "-- Finding all tools/library install files"
tools=($(ls -d tools/*.sh))
libraries=($(ls -d cpp/*.sh))
platforms=($(ls -d platforms/*.sh))

echo "-- Finding constants file"
CONSTANTS_FILE=./constants.sh
if [ -f "$CONSTANTS_FILE" ]; then
	echo "Constants file found"
else
	echo "Constants file NOT FOUND"
	exit 1
fi

echo "-- Creating install files for tools"
cat $CONSTANTS_FILE >> $INSTALL_FILE
for tool in "${tools[@]}"; do
#  echo "$tool"
  echo "# *** DO NOT CHANGE HERE ***" >> $INSTALL_FILE
  echo "# Source from: $tool" >> $INSTALL_FILE
	cat "$tool" >> $INSTALL_FILE
	echo "\n\n" >> $INSTALL_FILE
done

echo "-- Creating install files for libraries"
for lib in "${libraries[@]}"; do
#  echo "$lib"
  echo "# *** DO NOT CHANGE HERE ***" >> $INSTALL_FILE
  echo "# Source from: $lib" >> $INSTALL_FILE
	cat "$lib" >> $INSTALL_FILE
	echo "\n\n" >> $INSTALL_FILE
done

echo "-- Creating install files for platforms"
for plat in "${platforms[@]}"; do
  if [[ "$plat" != "platforms/init.sh" ]]; then
#    echo "$plat"
    echo "# *** DO NOT CHANGE HERE ***" >> $INSTALL_FILE
    echo "# Source from: $plat" >> $INSTALL_FILE
    cat "$plat" >> $INSTALL_FILE
    echo "\n\n" >> $INSTALL_FILE
  fi
done

echo "# *** DO NOT CHANGE HERE ***" >> $INSTALL_FILE
echo "# Source from: platforms/init.sh" >> $INSTALL_FILE
cat "platforms/init.sh" >> $INSTALL_FILE

which -s hostname
if [[ $? == 0 && `hostname` == "STEVEN.local" ]] ; then
  echo "-- Copying vimrc file"
  cp ~/.vimrc ./tools/vimrc
fi
echo "-- done"