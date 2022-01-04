if [ -f ~/.bashrc ]; then . ~/.bashrc; fi 
# source /usr/local/opt/chruby/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh
# source ~/.rvm/scripts/extras/chruby.sh
source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi

source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# OPAM configuration

. /home/pawan/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
if [ -e /Users/pawandubey/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/pawandubey/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
source "$HOME/.cargo/env"

alias jt="$(which ruby) /Users/pawandubey/src/github.com/Shopify/truffleruby-ws/truffleruby/tool/jt.rb"

