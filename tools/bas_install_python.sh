#!/bin/bash
do_run=1 # Execute(evaluate) the commands
#do_run=0 # Don't evaluate any commands
#do_echo=1 # Echo the commands
do_echo=0 # Don't echo any commands
#
echo ""
#destdir="/home/user/projects/hana-python-securestore/tools"
#destdir="/home/user"
pyver="3_9_2"
pymin="3.9"
rcfile="~/.bashrc"
#rcfile="bashrc"

if [ "$#" -ge 1 ]; then
  pyver=$1
  if [ $pyver = "3_9_0" ]; then
    echo "Version 3_9_0 cool."
    pymin="3.9"
  else
    if [ $pyver = "3_9_2" ]; then
      echo "Version 3_9_2 cool."
      pymin="3.9"
    else
      echo "Version $pyver is not supported, try again with 3_9_0 or 3_9_2."
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
echo "Installing Python Version $pyver."

echo ""
echo "Changing to "$destdir
cmd='cd '$destdir
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Downloading python_"$pyver".tgz"
cmd='curl -JLOC - https://github.com/SAP-samples/hana-python-securestore/releases/download/v0.0.0/python_'$pyver'.tgz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Untarring python_"$pyver".tgz"
cmd='tar xzf python_'$pyver'.tgz'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Appending Python related environment vars to "$rcfile
cmd='echo '"''"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'# Python specific environment variables.'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'export PYTHONHOME='$destdir'/python_'$pyver''"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'export PYTHONPATH=$PYTHONHOME/lib/python'$pymin''"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='echo '"'"'export PATH='$destdir'/python_'$pyver'/bin:$PATH'"'"' >> '$rcfile
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='export PYTHONHOME='$destdir'/python_'$pyver
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='export PYTHONPATH=$PYTHONHOME/lib/python'$pymin
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='export PATH='$destdir'/python_'$pyver'/bin:$PATH'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Get Python Version"
cmd='python -V'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Update Python Tools"
cmd='pip install --upgrade pip'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='pip install --upgrade setuptools'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

cmd='pip install --upgrade wheel'
if [ $do_echo -eq 1 ]; then echo $cmd; fi
if [ $do_run -eq 1 ]; then eval $cmd; fi

echo ""
echo "Install of python_"$pyver" finished."

