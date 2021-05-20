#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
do_echo=1 # Echo the commands
#do_echo=0 # Don't echo any commands
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

#cmd='notroot install mitmproxy'
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

#cmd='sed -i -e "s/\/usr\/bin\/python3/\/home\/user\/notroot\/usr\/bin\/python3/g" /home/user/notroot/usr/bin/mitmproxy'
#if [ $do_echo -eq 1 ]; then echo $cmd; fi
#if [ $do_run -eq 1 ]; then eval $cmd; fi

#https://tools.hana.ondemand.com/additional/btp-cli-linux-amd64-2.0.0.tar.gz
#https://tools.hana.ondemand.com/#cloud

cmd='curl -L -o '$destdir'/thetacli http://thedrop.sap-partner-eng.com/files/thetacli'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='chmod 755 '$destdir'/thetacli'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"''"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'# Add THETA CLI to PATH.'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'export PATH='$destdir':$PATH'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='export PATH='$destdir':$PATH'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='thetacli version'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='curl -L -o /home/user/thetacli_keys.tgz http://thedrop.sap-partner-eng.com/files/thetacli_keys.tgz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='tar -C /home/user -xzf /home/user/thetacli_keys.tgz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='chmod 700 /home/user/.thetacli/keys/encrypted'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='npm install -g solc'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='solcjs -V'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

