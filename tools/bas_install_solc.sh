#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
echo ""
#destdir="/home/user/projects/hana-golang-securestore/tools"
#destdir="/home/user"
solcver="0_4_16"
solcmin="0.4.16"
rcfile="~/.bashrc"
#rcfile="bashrc"

if [ "$#" -ge 1 ]; then
  solcver=$1

  case $solcver in

  0_8_4)
    echo "Version 0_8_4 cool."
    solcmin="0.8.4"
    ;;

  0_7_6)
    echo "Version 0_7_6 cool."
    solcmin="0.7.6"
    ;;

  0_6_12)
    echo "Version 0_6_12 cool."
    solcmin="0.6.12"
    ;;

  0_5_17)
    echo "Version 0_5_17 cool."
    solcmin="0.5.17"
    ;;

  0_5_0)
    echo "Version 0_5_0 cool."
    solcmin="0.5.0"
    ;;

  0_4_26)
    echo "Version 0_4_26 cool."
    solcmin="0.4.26"
    ;;

  0_4_16)
    echo "Version 0_4_16 cool."
    solcmin="0.4.16"
    ;;

  0_3_6)
    echo "Version 0_3_6 cool."
    solcmin="0.3.6"
    ;;

  0_2_2)
    echo "Version 0_2_2 cool."
    solcmin="0.2.2"
    ;;

  0_1_7)
    echo "Version 0_1_7 cool."
    solcmin="0.1.7"
    ;;

  *)
    echo -n "unknown"
    echo "Version $solcver is not supported, try again."
    exit 1
    ;;

  esac
fi

if [ "$#" -ge 2 ]; then
  destdir=$2
else
  destdir="/home/user/bin"
fi

echo ""
echo "Checking if $destdir exists."

if [ -d "$destdir" ]; then

echo ""
echo $destdir exists!
else
echo ""
echo $destdir does not exist.  Creating!
cmd='mkdir -p '$destdir''
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi
fi

echo ""
echo "Installing SOLC Version $solcver."

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# https://github.com/ethereum/solidity/releases/tag/v0.4.16
# https://github.com/ethereum/solidity/releases/download/v0.4.16/solc-static-linux

# XXXXX
echo ""
cmd='curl -L -o '$destdir'/solc https://github.com/ethereum/solidity/releases/download/v'$solcmin'/solc-static-linux'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='chmod 755 '$destdir'/solc'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

#cmd='echo '"''"' >> '$rcfile
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

#cmd='echo '"'"'# Add SOLC to PATH.'"'"' >> '$rcfile
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

#cmd='echo '"'"'export PATH='$destdir':$PATH'"'"' >> '$rcfile
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

#cmd='export PATH='$destdir':$PATH'
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Get SOLC Version"
cmd=$destdir'/solc --version'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of solc_"$solcver" finished."

