#!/bin/bash
# Example of calling a subcommand from a command

# The at sign will return all inputs other than zero
echo "All inputs: "$@
echo "If the first input is "master-minion.sh", the command will automatically be called with the appropriate inputs"

if [[ "$1" == "master-minion.sh" ]]
then
  subcommand=$1
  # Use shift to remove the first command
  shift
  # Call the subcommand
  bash $subcommand $@
elif [[ "$1" == "cat" ]]
then
  subcommand=$1
  shift
  # We can directly call command if it's in PATH
  $subcommand $@
fi

# Note that this can be very useful for scripting command-subcommands in a package. 
# If the subcommand is in PATH, we can directly call the subcommand, like in the cat command example
