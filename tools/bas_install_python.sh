#!/bin/bash
#echo ""
pyver="3_9_0"
#rcfile="~/.bashrc"
rcfile="bashrc"
space="DEV"
path=$2
proj="python-dev-env"
app=$proj"_"$path
host=$app"-"$path
dowait=""
doexport1=""
doexport2=""
if [ "$#" -eq 1 ]; then
  pyver=$1
  echo $pyver
  if [ $pyver = "3_9_0" ]; then
    echo "Version 3_9_0 cool."
  else
    if [ $pyver = "3_9_1" ]; then
      echo "Version 3_9_1 cool."
    else
      echo "Version $pyver is not supported, try again."
      exit 1
    fi
  fi
  #echo Client HDI $pyver Deploy into org: $org space: $space Starting 
  #echo ""

  instance=$proj"-hdi"

  #echo ""

  #cmd='VCAP_SERVICES=$('$pyver' env '$app' '$doexport1' | jq -r '"'"'.VCAP_SERVICES'"'"$doexport2')'
  ##echo $cmd
  #eval $cmd
  #echo $VCAP_SERVICES
fi

echo "Installing Python Version $pyver."

cmd='cd /home/user'
echo $cmd
#eval $cmd

cmd='cd /home/user'
echo $cmd
#eval $cmd

curl -JLOC - https://github.com/SAP-samples/hana-python-securestore/releases/download/v0.0.0/python_3_9_0.tgz
tar xzvf python_3_9_0.tgz
echo '' >> ~/.bashrc
echo '# Python specific environment variables.' >> ~/.bashrc
echo 'export PYTHONHOME=/home/user/python_3_9_0' >> ~/.bashrc
echo 'export PYTHONPATH=$PYTHONHOME/lib/python3.9' >> ~/.bashrc
echo 'export PATH=/home/user/python_3_9_0/bin:$PATH' >> ~/.bashrc

