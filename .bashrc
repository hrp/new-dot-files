# .bashrc

# User specific aliases and functions
# source /etc/profile

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

#####
# Z is the new J
# . ~/tools/z.sh

#################
# Aliases

# -> Prevents accidentally clobbering files.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# easier to jump around
alias ..='cd ..'

# vim alias
alias vi=vim

# force colors on ls
if [[ $OSTYPE == 'linux-gnu' ]]; then
  alias ls='ls --color=always -B'
elif [[ $OSTYPE == 'darwin10.0' ]]; then
  alias ls='ls -G'
fi

alias ll='ls -l'

# force colors on grep
alias grep='grep --color=AUTO'
alias fgrep='fgrep --color=AUTO'

# set default editor
export EDITOR=/usr/bin/vim

# Set the window title for screen
  case $TERM in
    screen*)
      # This is the escape sequence ESC k \w ESC \
      #Use path as title
      SCREENTITLE='\[\ek\w\e\\\]'
      #Use program name as title
      # SCREENTITLE='\[\ek\e\\\]'
      ;;
    *)
      SCREENTITLE=''
      ;;
  esac

# Turn off XON/XOFF process control to make <CTRL-s> not hang VIM and Command-T
# See: https://wincent.com/forums/command-t/topics/430
stty -ixon


PS1="${SCREENTITLE}${PS1}"

# Path
PATH=.:$PATH:/usr/local/bin
PATH=$PATH:~/vsatools/bin
export PATH



# SSH PASSPHRASE
# Using ssh-agent to remember pass phrases
# Because pass phrases are for suckers

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi


[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm




export PATH=$HOME/local/bin:$PATH
