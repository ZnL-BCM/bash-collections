#!/bin/bash
# This is a demonstration of basic examples

# Function for displaying help
function help (){
  echo -e "This is the usage screen of the example function.\n"
  echo -e "Options: "
  echo -e "-a|--alpha\tdefine value of alpha for output"
  echo -e "-b|--beta\tdefine value of long, input can be extended indefinitely"
  echo -e "-c|--CAT\tcall the subprocess cat and opens the associated file"
  echo -e "-D|--default\tdefine a value that has a default value of FOO"
  echo -e "-D2|--default2\tdefine a value that has a default value of GOO, but will trigger even without the flag"
  echo -e "-E|--ECHO\techoes all remaining commands (will override -c)"
  echo -e "-p|--python\tcalls an embedded python script"
  echo -e "-p2|--python2\tcalls an embedded python script and displays it in-line"
  echo -e "-h|--help\tprint help"
  echo -e "--version\tprint version information"
  exit 0
}

# Function for displaying version
function version_ctrl () {
  echo -e "Example script\nCurrent version: v0.1.0"
  exit 0
}

# Embedded python function example
function python_hello () {
  echo -E '
import numpy as np
import sys
print("Version numbers: ")
print(sys.version)
print(np.__version__)
foo=np.array(["w", "o", "r", "l", "d"])
print("Hello")
print(foo)
'
}

# First, check if there is no detectable input or too many (arbitrarily defined as 20 for now)
if [ $# -eq 0 ]; then
  echo -e "No input detected, showing help:\n"
elif [ $# -gt 20 ]; then
  echo "You have too many inputs! Current input count is $#"; exit 1
fi

# Main condition check, do so for each special input
while [ ! -z "$1" ]; do
  case "$1" in
    -h|--help) help;;
    --version) version_ctrl;;
    -a|--alpha) shift; A="$1";;
    -b|--beta)
      shift; B="$1"
      while [[ "$2" != "-"* ]] && [[ $# -gt 1 ]] ; do
        shift; B+=" $1"
      done
    ;;
    -c|--CAT)
      shift; subcommand="cat"; subval="$1";;
    -D|--default)
      shift; def="${1:-FOO}";;
    -D2|--default2)
      shift; def2="$1";;
    -E|--ECHO)
      shift; subcommand="echo"; subval="$1";
      while [[ "$2" != "-"* ]] && [[ $# -gt 1 ]] ; do shift; subval+=" $1"; done;;
    -p|--python)
      python_hello | python -
      echo -e "You should have just seen the python script being executed. Exit now."; exit 0;;
    -p2|--python2)
      python2flag=1;;
    *)
  echo -e "Incorrect input provided, show help:\n"
  help
  esac
shift
done


echo -e "This is the main function:\n"

echo -e "Value of alpha for -a: $A\n"

echo -e "Value of beta for -b: $B. Now print each value in beta:"
for item in $B; do echo $item; done
echo ""

echo -e "If the option -c or -E is included, you should see it executing the associated command here: "
$subcommand $subval | head -n 5
echo ""

echo -e "Value of default for -D (default is FOO): $def \n"

echo -e "Value of default for -D2 (default is GOO): "${def2:-GOO}"\n"

echo -e "If the option -p2 is included, you should see a python script showing right below this sentence:"
if [ ! -z "$python2flag" ]; then
  python_hello | python -
fi
