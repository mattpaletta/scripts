echo "-- Initialiazing platform"
if [[ is_mac ]]; then
  $mac
elif [[ is_linux ]]; then
  $ubuntu
fi

echo "-- Running Main"
_found_help=false
_found_file=false
_install_all=false
_file=""

_is_next_file=false
for arg in "$@"
do
    if [ "$arg" == "--all" ] || [ "$arg" == "-a" ]
    then
        _install_all=true
        break
    fi

    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        _found_help=true
    fi

    if [ "$arg" == "--file" ] || [ "$arg" == "-f" ]
    then
      if [ "$_found_file" == false ]
      then
        _is_next_file=true
      else
        echo "Only one file allowed. See --help for more info."
        exit 1
      fi
    fi

    if [ "$_is_next_file" == true ]
    then
      _file="$arg"
      _is_next_file=false
      if [[ -f "$_file" ]]; then
        _found_file=true
      else
        echo "Input file not found: $arg"
        exit 1
      fi
    fi
done

if [[ "$_install_all" == true ]]
then
  echo "-- Installing all"
  $brew
  $cmake
  $cpp
  $docker
  $java
  $jetbrains
  $mas
  $maven
  $python
  $swift
  $swig
  $vim
elif [[ "$_found_file" == true ]]
then
  echo "-- Processing input file"
  while IFS= read -r line
  do
    echo "Installing: $line"
    ${line}
  done < "$_file"
else
  echo "-- Processing from args"
  for arg in "$@"
  do
    echo "Installing: $arg"
    ${arg}
  done
fi
echo "-- Finished processing"