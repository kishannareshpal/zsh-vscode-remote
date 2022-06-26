# Open visual studio remotely connected via ssh
# https://github.com/kishannareshpal/vscode-ssh-remote
# v0.0.1
# Copyright (c) 2022 Kishan Jadav
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.


USE_AUTOJUMP=true

function coder() {
  # Check to see if the ssh remote has autojump installed
  if ! command -v j &> /dev/null
  then
    USE_AUTOJUMP=false
    echo 'Please install `autojump` plugin in the host, for better ux'
    exit
  fi

  # Grab the path of the directory we're opening remotely
  DIR_PATH=`
    ssh $1 exec "
      . ~/.zshrc;
      if command -v j &> /dev/null
      then
        j $2
      else
        echo $2
      fi
    "
  `

  # Open VSCode remote in host at the directory
  code --remote ssh-remote+$1 $DIR_PATH
}