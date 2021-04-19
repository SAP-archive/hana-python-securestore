#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
echo ""
#destdir="/home/user/projects/hana-golang-securestore/tools"
#destdir="/home/user"
gover="1_12_1"
gomin="1.12.1"
rcfile="~/.bashrc"
#rcfile="bashrc"

if [ "$#" -ge 1 ]; then
  gover=$1
  if [ $gover = "1_12_1" ]; then
    echo "Version 1_12_1 cool."
    gomin="1.12.1"
  else
    if [ $gover = "1_13_15" ]; then
      echo "Version 1_13_15 cool."
      gomin="1.13.15"
    else
      if [ $gover = "1_16_3" ]; then
        echo "Version 1_16_3 cool."
        gomin="1.16.3"
      else
        echo "Version $gover is not supported, try again."
        exit 1
      fi
    fi
  fi
fi

if [ "$#" -ge 2 ]; then
  destdir=$2
else
  destdir="/home/user/goroot"
fi


echo ""
echo "Installing GoLang Version $gover."

echo ""
echo "Creating "$destdir
cmd='mkdir -p '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Creating "$HOME"/go"
cmd='mkdir -p '$HOME'/go'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# Install NOTROOT  (installs jq as a side-effect)

# notroot install build-essential
# notroot install gcc
# notroot install make
# notroot install bzr
# curl -LO https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
# tar -C /home/user/notroot -xzf /home/user/go1.12.1.linux-amd64.tar.gz 
# echo '' >> ~/.bashrc
# echo 'export GOROOT=/home/user/notroot/go' >> ~/.bashrc 
# echo 'export GOPATH=$HOME/go' >> ~/.bashrc
# echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
# echo 'export THETA_HOME=$GOPATH/src/github.com/thetatoken/theta' >> ~/.bashrc

echo ""
echo "Downloading go"$gomin".tar.gz"
cmd='curl -LO https://dl.google.com/go/go'$gomin'.linux-amd64.tar.gz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Untarring go"$gomin".tar.gz"
cmd='tar -C '$destdir' -xzf go'$gomin'.linux-amd64.tar.gz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Appending GoLang related environment vars to "$rcfile
cmd='echo '"''"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'# GoLang specific environment variables.'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# echo 'export GOROOT=/home/user/notroot/go' >> ~/.bashrc 
cmd='echo '"'"'export GOROOT='$destdir'/go'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# echo 'export GOPATH=$HOME/go' >> ~/.bashrc
cmd='echo '"'"'export GOPATH=$HOME/go'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
cmd='echo '"'"'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

# echo 'export THETA_HOME=$GOPATH/src/github.com/thetatoken/theta' >> ~/.bashrc
cmd='echo '"'"'export THETA_HOME=$GOPATH/src/github.com/thetatoken/theta'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Get GoLang Version"
cmd=$destdir'/go/bin/go version'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of golang_"$gover" finished."

