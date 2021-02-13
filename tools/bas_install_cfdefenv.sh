#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
echo ""
#destdir="/home/user/projects/hana-python-securestore/tools"
#destdir="/home/user"
pluginver="1_0_0"
pluginmin="1.0.0"
rcfile="~/.bashrc"
#rcfile="bashrc"

if [ "$#" -ge 1 ]; then
  pluginver=$1
  if [ $pluginver = "1_0_0" ]; then
    echo "Version 1_0_0 cool."
    pluginmin="1.0.0"
  else
    if [ $pluginver = "1_0_1" ]; then
      echo "Version 1_0_1 cool."
      pluginmin="1.0.1"
    else
      echo "Version $pluginver is not supported, try again."
      exit 1
    fi
  fi
fi

if [ "$#" -ge 2 ]; then
  destdir=$2
else
  destdir="/home/user"
fi


echo ""
echo "Installing CF DefaultEnv Plugin Version $pluginver."

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Downloading CF DefaultEnv Plugin "$pluginmin".linux64"
cmd='curl -LO https://github.com/saphanaacademy/DefaultEnv/releases/download/v'$pluginmin'/DefaultEnv.linux64'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi


//cf install-plugin DefaultEnv.linux64
echo ""
echo "Installing CF DefaultEnv Plugin "$pluginmin".linux64"
cmd='cf install-plugin DefaultEnv.linux64 -f'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi


echo ""
echo "Check CF Plugins Version"
cmd='cf plugins'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of CF DefaultEnv Plugin "$pluginmin" finished."

