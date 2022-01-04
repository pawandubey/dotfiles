# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]𝞴 '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w 𝞴 '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Custom bash prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

bold()                                 { ansi 1 "$@"; }
italic()                               { ansi 3 "$@"; }
underline()                            { ansi 4 "$@"; }
strikethrough()                        { ansi 9 "$@"; }
gitprompt()                            { ansi "38;5;069" "$@"; }
green_foreground()                     { ansi "38;5;036" "$@"; }
green_background_white_foreground()    { ansi "48;5;036;38" "$@"; }
purple_bold_foreground()               { ansi "35;1" "$@"; }
ansi()                                 { echo "\[\e[${1}m\]${*:2}\[\e[0m\]"; }

normal=$(tput sgr0)

function gitps1() {
    echo "\$(__git_ps1 \"on $(bold %s)\")"
}

function ruby_version() {
    if [ $RUBY_VERSION ] ; then
        echo " : [$RUBY_VERSION] :"
    fi
}

export PS1=`echo -e "\$(bold \$(green_background_white_foreground ' \u '))\$(green_foreground '\$(ruby_version)') \$(purple_bold_foreground ['\W']) \$(gitprompt \$(italic \$(gitps1)))\n\$(green_foreground ★ 𝞴) "`

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
# source /home/pawandubey/.oh-my-git/prompt.sh
bind TAB:menu-complete
bind "set show-all-if-ambiguous on"

if [[ -f /user/share/bash-completion/completions/pass ]]; then
  source /usr/share/bash-completion/completions/pass
elif [[ -f /usr/local/etc/bash_completion.d/pass ]]; then
  source /usr/local/etc/bash_completion.d/pass
fi

source ~/git-completion.bash

# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi

if [[ -f ~/.local/share/icons-in-terminal/icons_bash.sh ]]; then
  source ~/.local/share/icons-in-terminal/icons_bash.sh
fi

if [[ -f ~/.bash_functions ]]; then
  source ~/.bash_functions
fi

export PROJECTS_DIR=~/src/github.com/pawandubey/
export SHOPIFY_DIR=~/src/github.com/Shopify/
export DISPLAY=:0
export TERM=xterm-256color
if [[ "$OSTYPE" == "darwin"* ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
else
    export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
fi
export ECLIPSE_HOME=~/.local/share/umake/ide/eclipse
export GOPATH=~/go
PATH=~/griffin/bin:$GOPATH/bin:$PATH
source "$HOME/.cargo/env"
# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/pawandubey/.kube/config:/Users/pawandubey/.kube/config.shopify.cloudplatform

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)
