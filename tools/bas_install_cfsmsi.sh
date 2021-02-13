#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
echo ""
#destdir="/home/user/projects/hana-python-securestore/tools"
#destdir="/home/user"
pluginver="1_2_4"
pluginmin="1.2.4"
rcfile="~/.bashrc"
#rcfile="bashrc"

#if [ "$#" -ge 1 ]; then
#  pluginver=$1
#  if [ $pluginver = "1_1_1" ]; then
#    echo "Version 1_1_1 cool."
#    pluginmin="1.1.1"
#  else
#    if [ $pluginver = "1_1_1" ]; then
#      echo "Version 1_1_1 cool."
#      pluginmin="1.1.1"
#    else
#      echo "Version $pluginver is not supported, try again."
#      exit 1
#    fi
#  fi
#fi

if [ "$#" -ge 2 ]; then
  destdir=$2
else
  destdir="/home/user"
fi


echo ""
echo "Installing CF SMSI Plugin Version."

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# Use this if you can get the plugin published on plugins.cloudfoundry.org
#echo ""
#echo "Installing Latest SMSI CF Plugin"
#cmd='cf install-plugin -r CF-Community "service-management" -f'
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi


# Otherwise download and install directly
echo ""
echo "Downloading CF SMSI Plugin "$pluginmin".linux64"
cmd='curl -LO https://github.com/SAP/cf-cli-smsi-plugin/releases/download/v'$pluginmin'/ServiceManagement.linux64'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

//cf install-plugin ServiceManagement.linux64
echo ""
echo "Installing CF SMSI Plugin "$pluginmin".linux64"
cmd='cf install-plugin ServiceManagement.linux64 -f'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi


echo ""
echo "Check CF Plugins Version"
cmd='cf plugins'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of CF SMSI Plugin finished."

