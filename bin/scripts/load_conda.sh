#!/bin/bash

# Accept an environment as a parameter or set to default
export MY_ENV_DEFAULT="python3.6"
if [ $# -eq 0 ]; then
    export MY_ENV=$MY_ENV_DEFAULT
elif [ $# -eq 1 ]; then
    re='^[0-9]+([.][0-9]+)?$'
    if ! [[ $1 =~ $re ]] ; then
        export MY_ENV=$1
    else
        export MY_ENV="python"$1
    fi
else
    echo 'Syntax: '$0 ' <optional: conda_environment>'
    return 2
fi

# Decide what sort of system we're on
if [ -f /bin/uname ] || [ -f /usr/bin/uname ]; then
  export GBP_OS=$(uname)
  if [ $GBP_OS = 'Darwin' ]; then
     export GBP_OS='Mac'
     export PATH=/anaconda/bin:$PATH
  elif [ $GBP_OS = 'Linux' ]; then
     export GBP_OS='linux'
  fi
else
  echo Unknown OS type: ${GBP_OS}.
  export GBP_OS='unknown'
fi

# Perform system-specific setup
export GBP_HOSTNAME=$(hostname)
if [ -n $GBP_HOSTNAME ]; then

  # Set-up for nodes on the Swinburne 'OzStar' cluster
  if [[ $GBP_HOSTNAME = farnarkle* ]] ; then
    source activate $MY_ENV >> /dev/null 2>&1
  elif [[ $GBP_HOSTNAME = john* ]] ; then
    source activate $MY_ENV >> /dev/null 2>&1
  # Set-up for nodes on the Swinburne 'g2' cluster
  elif [ $GBP_HOSTNAME = 'g2.hpc.swin.edu.au' ] || [[ $GBP_HOSTNAME = sstar* ]] ; then
    export TCL_LIBRARY="/usr/local/x86_64/anaconda-2.2.0/pkgs/tk-8.5.18-0/lib/tcl8.5/"
    module load anaconda
    source activate $MY_ENV >> /dev/null 2>&1
  # Set-up for OSX
  elif [ $GBP_OS = 'Mac' ]; then
    source activate $MY_ENV >> /dev/null 2>&1
  # Unknown host.  Let the user know.
  else
    echo "Unknown hostname:" $GBP_HOSTNAME
    return 1
  fi
  echo "Anaconda environment set to ($MY_ENV)."
fi
