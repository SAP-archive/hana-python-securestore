#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
# See https://blogs.sap.com/2020/12/10/xtending-business-application-studio-1-of-3/
#
echo ""
#destdir="/home/user/projects/hana-python-securestore/tools"
#destdir="/home/user"
nrver="0_0_1"
rcfile="~/.bashrc"
#rcfile="bashrc"

if [ "$#" -ge 1 ]; then
  nrver=$1
  if [ $nrver = "0_0_1" ]; then
    echo "Version 0_0_1 cool."
  else
    if [ $nrver = "0_0_2" ]; then
      echo "Version 0_0_2 cool."
    else
      echo "Version $nrver is not supported, try again."
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
echo "Installing NOTROOT Version $nrver."

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

#git clone https://github.com/andrewlunde/notroot.git /home/user/notroot
#cat /home/user/notroot/add2bashrc.txt >> ~/.bashrc
#export APT_CONFIG=/home/user/notroot/apt.conf
#source "$HOME/notroot/bashrc"
#export PERL5LIB=/home/user/notroot/usr/lib/x86_64-linux-gnu/perl5/5.28:$PERL5LIB
#/home/user/notroot/prepapt

echo ""
echo "Cloning notroot "$nrver"."
cmd='git clone https://github.com/andrewlunde/notroot.git /home/user/notroot'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Modifying .bashrc"
cmd='cat /home/user/notroot/add2bashrc.txt >> ~/.bashrc'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Export APT_CONFIG"
cmd='export APT_CONFIG=/home/user/notroot/apt.conf'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Source bashrc"
cmd='source "$HOME/notroot/bashrc"'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Export PERL5LIB"
cmd='export PERL5LIB=/home/user/notroot/usr/lib/x86_64-linux-gnu/perl5/5.28:$PERL5LIB'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Prepping APT"
cmd='/home/user/notroot/prepapt'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi


echo ""
echo "Get JQ Version"
cmd='jq -V'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of NOTROOT_"$nrver" finished."

