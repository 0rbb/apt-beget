:<<=
==create common folders that we are will store temporary files and end result
=
function prepare_folders {
  mkdir -p $HOME/.beget/tmp
  mkdir -p $HOME/.local/opt
  mkdir -p $HOME/.local/bin

  rm -rf $HOME/.beget/tmp/*
  rm -rf $HOME/.beget/tmp/.*

  cd $HOME/.beget/tmp
}
