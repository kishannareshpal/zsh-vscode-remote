## zsh-vscode-remote

### `coder`

`coder` is a zsh / bash program that allows you to open VSCode remotely connected to an ssh host and directory.

It's mostly a wrapper around [`code --remote ...`](https://code.visualstudio.com/docs/remote/ssh) + [wting/autojump](https://github.com/wting/autojump)

### Usage

Let's say you want to open your `myprojects` directory in a remote computer via ssh. Just do:
```bash
# Pass in the absolute path to the 'myprojects' directory on host
$ coder 192.168.1.101 '/users/kishan/myprojects'

# Or simply leaverage the power of autojump to quickly select the myprojects directory on host
#   If you don't have `wting/autojump` installed and aliased as 'j' in the host,
#   the program will fallback to use the value of -j as the absolute path.
$ coder 192.168.1.101 -j myprojects
```

```bash
$ coder --help
# Open VSCode remotely connected to an ssh host and directory. A wrapper around 'code --remote ...'
# 
# Usage: coder <SSH-HOST> [-h|--help]|[-v|--version]|[-j DIRECTORY|<ABSOLUTE-DIRECTORY-PATH>]
# 
# Optional positional arguments:
#   ABSOLUTE-DIREACTORY-PATH    Full path of the directory to open. Defaults to no directory.
# 
# Available options:
#   -j <DIRECTORY>              Use 'wting/autojump' in host for selecting the DIRECTORY to open
#   -h, --help                  Print this help message
#   -v, --version               Show the version
```

### Install

##### OMZ
```bash
# Clone the repo into ~/.oh-my-zsh/custom/plugins/zsh-vscode-remote/:
$ git clone https://github.com/kishannareshpal/zsh-vscode-remote ~/.oh-my-zsh/custom/plugins/zsh-vscode-remote

# Now open your ~/.zshrc, with any editor:
$ nano ~/.zshrc

# Add 'zsh-vscode-remote' to the plugins list:
plugins=(…, zsh-vscode-remote)

# Save and quit, then source the shell:
$ . ~/.zshrc

# You can confirm it's installed by running:
$ coder -v
# coder version x.y.z (YYYY-MM-DD)
# https://github.com/kishannareshpal/zsh-vscode-remote
```

##### Good to haves in the host machine:
  * [wting/autojump](https://github.com/wting/autojump) - Install on your host machine to use the `-j <DIRECTORY>` option
  in order to quickly select the directory in the host.

