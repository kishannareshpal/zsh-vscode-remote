# Open visual studio remotely connected via ssh
# https://github.com/kishannareshpal/zsh-vscode-remote
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

function _version() {
  echo "coder version 0.0.3 (2022-06-26)"
  echo "https://github.com/kishannareshpal/zsh-vscode-remote"
}

function _help() {
  # Display Help
  echo "Open VSCode remotely connected to an ssh host and directory. A wrapper around 'code --remote ...'"
  echo
  echo "Usage: coder <SSH-HOST> [-h|--help]|[-v|--version]|[-j DIRECTORY|<ABSOLUTE-DIRECTORY-PATH>]"
  echo 
  echo "Optional positional arguments:"
  echo "  ABSOLUTE-DIREACTORY-PATH    Full path of the directory to open. Defaults to no directory."
  echo 
  echo "Available options:"
  echo "  -j <DIRECTORY>              Use 'wting/autojump' in host for selecting the DIRECTORY to open"
  echo "  -h, --help                  Print this help message"
  echo "  -v, --version               Show the version"
  echo
}

function coder() {
  ### Misc
  BLUE="34"
  CYAN="96"
  BOLDBLUE="\e[1;${BLUE}m"
  ITALICCYAN="\e[3;${CYAN}m"
  ENDCOLOR="\e[0m"

  ### Options
  # Remote host
  optsOrHostIP="$1"
  # Absolute path to the file / directory on the host to open
  # Or, if it starts with a dash, then the option
  dirOrOpt="$2"
  # If argument $2 is an option, than this will be used as the value for that option
  # Otherwise, unused.
  optValue="$3"
  
  ### Vars
  # The absolute path of the directory to open vscode remotely into.
  finalDirPath=""

  ### Handle options if available
  opts=$optsOrHostIP
  case $opts in
    "");&
    "-h");&
    "--help")
      # Print an help message
      _help
      return``
      ;;
    "-v");&
    "--version")
      # Show the version
      _version
      return
      ;;
  esac

  hostIP=$optsOrHostIP
  case $dirOrOpt in
    "-j"*)
      # Attempt to use autojump on host to find the directory to open
      finalDirPath=`
        ssh $hostIP exec "
          . ~/.zshrc;
          if command -v j &> /dev/null
          then
            j $optValue
          else
            echo $optValue
          fi
        "
      `
      ;;
    *)
      # Use the absolute directory path provided. 
      # Defaults to '.' (which won't open any directory at all in the host)
      finalDirPath="${dirOrOpt:-'.'}"
      ;;
  esac

  # Open VSCode remote in host at the chosen directory
  code --remote "ssh-remote+$hostIP" ${finalDirPath}
  echo -e "${BOLDBLUE}Opening VSCode remotely connected via ssh to: $hostIP.${ENDCOLOR}"
  echo -e "${ITALICCYAN}→ Selected directory: ${finalDirPath:-"No directory selected"}.${ENDCOLOR}"
}