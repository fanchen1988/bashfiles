# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Start
START_AT=$(ruby -e "puts Time.now.to_f")

# Customize
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=UTF-8
export TERM=xterm-256color
export EDITOR=vim

# OS-based setting
if [ -f $HOME/.bash/rc.os/`uname -s` ] ; then
  source $HOME/.bash/rc.os/`uname -s`
fi

# rcs
for file in `ls $HOME/.bash/rc` ; do
  source $HOME/.bash/rc/$file
done

# completions
for file in `ls $HOME/.bash/completion.d` ; do
  source $HOME/.bash/completion.d/$file
done

# COLOR DEFINER
source $HOME/.bash/color

# ext path
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

PS1="$COLOR_TXT_GRN\u@\h$COLOR_TXT_RST:$COLOR_TXT_BLU\w\$$COLOR_TXT_RST "

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

bind "set completion-ignore-case on"
bind "set completion-prefix-display-length 2"
bind "Control-j: menu-complete"
bind "Control-k: menu-complete-backward"
bind "set completion-map-case on"

if command -v autojump >/dev/null 2>&1; then
  source $(greadlink -f $(dirname $(greadlink -f $(which autojump)))/../share/autojump/autojump.bash)
fi

# Welcome
ruby -e "puts %{It takes #{format('%.3f',Time.now.to_f - $START_AT)} second(s) to launch this shell env my Lord!}"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
