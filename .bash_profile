# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# PATH=$PATH:$HOME/ruby/trunk/bin
# PATH=$HOME/ruby/trunk/bin:$HOME/tools/git/git-1.7.0.5/:$PATH
# PATH=$HOME/sandbox:$PATH
# PATH=$PATH:/usr/local/bin
export PATH

unset USERNAME

function promptl
{
local WHITE="\[\033[1;37m\]"
local GREEN="\[\033[0;32m\]"
local CYAN="\[\033[0;36m\]"
local GRAY="\[\033[0;37m\]"
local BLUE="\[\033[0;34m\]"
local YELLOW="\[\033[1;33m\]"
PS1="${YELLOW}\w${CYAN} $ ${WHITE} "
export PS1="
${GRAY}\$(~/.rvm/bin/rvm-prompt i v) $PS1"
}
function promptm
{
local WHITE="\[\033[1;37m\]"
local GREEN="\[\033[0;32m\]"
local CYAN="\[\033[0;36m\]"
local GRAY="\[\033[0;37m\]"
local BLUE="\[\033[0;34m\]"
local YELLOW="\[\033[1;33m\]"
PS1="${CYAN}\w${GREEN} $ ${WHITE} "
export PS1="
${GRAY}\$(~/.rvm/bin/rvm-prompt i v) $PS1"
}

if [[ $OSTYPE == 'linux-gnu' ]]; then
  promptl
elif [[ $OSTYPE == 'darwin10.0' ]]; then
  promptm 
fi


echo ""
fortune

