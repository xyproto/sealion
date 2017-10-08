#!/bin/sh

cat << dog

----=[ Prompt Messages user setup script ]=----

dog

SOURCE_DIR=.
USER_CONF_DIR=.config/pmsg
PREFIX=$HOME
#BIN_DIR=usr/bin
BIN_DIR=.config/pmsg

# msg outputs a topic + green message, with a final newline
msg() {
  local topic="$1"
  shift
  if [ ! -z "$*" ]; then
    printf "%b" "* \e[1;37m[\e[0m\e[1;34m$topic\e[0m\e[1;37m]"
    printf ' %.0s' $(seq ${#topic} 25)
    printf "%b\n" "\e[0;32m$*\e[0m"
  fi
}

# Install $PREFIX/$BIN_DIR/pmsg, but only if $BIN_DIR is in /home
test "${PWD##/home/}" != "${PWD}" && if [ -x $PREFIX/$BIN_DIR/pmsg ]; then
  # Only upgrade the executable if the files differ
  diff -q "$SOURCE_DIR/pmsg" "$PREFIX/$BIN_DIR/pmsg" 2>&1 1>/dev/null && msg pmsg 'Already in place' || (msg pmsg "Installing to $PREFIX/$BIN_DIR/pmsg"; install -Dm755 "$SOURCE_DIR/pmsg" "$PREFIX/$BIN_DIR/pmsg")
else
  msg pmsg "Installing to $PREFIX/$BIN_DIR/pmsg"
  install -Dm755 "$SOURCE_DIR/pmsg" "$PREFIX/$BIN_DIR/pmsg"
fi

# Install to ~/$USER_CONF_DIR/time.conf
if [ ! -f $HOME/$USER_CONF_DIR/time.conf ]; then
  msg 'time.conf' "Installing to ~/$USER_CONF_DIR/time.conf"
  install -Dm644 "$SOURCE_DIR/time.example.conf" "$HOME/$USER_CONF_DIR/time.conf"
else
  msg 'time.conf' "Already in place"
fi

# Set up zsh, if not already set up
if [ -f ~/.zshrc ]; then
  already=0
  grep -q -F 'precmd() {' ~/.zshenv && already=1
  grep -q -F 'precmd() {' ~/.zshrc && already=1
  if [ "$already" == "1" ]; then
    msg zsh 'Already set up'
  else
    msg zsh 'Setting up'
    cat << EOF >> ~/.zshrc

# Prompt Messages
on() {
  precmd() { $BIN_DIR/pmsg }
  off() { unset -f precmd }
}
# Enable prompt messages if on the right host and not over ssh
[ "\$HOST" = "$HOSTNAME" ] && [ ! -n "\$SSH_TTY" ] && on
EOF
  fi
fi

# Set up bash, if not already set up
if [ -f ~/.bashrc ]; then
  already=0
  grep -q -F PROMPT_COMMAND= ~/.bash_profile && already=1
  grep -q -F PROMPT_COMMAND= ~/.bashrc && already=1
  if [ "$already" == "1" ]; then
    msg bash 'Already set up'
  else
    msg bash 'Setting up'
    cat << EOF >> ~/.bashrc

# Prompt Messages
on() {
  export PROMPT_COMMAND="$BIN_DIR/pmsg"
  off() { unset PROMPT_COMMAND; }
}
# Enable prompt messages if on the right host and not over ssh
[ \$HOSTNAME = "$HOSTNAME" ] && [ ! -n "\$SSH_TTY" ] && on
EOF
  fi
fi

# Set up fish, if not already set up
if [ -d ~/.config/fish ]; then
  already=0
  grep -q -F 'function pmsg --on-event fish_prompt' ~/.config/fish/config.fish 2>/dev/null && already=1
  if [ "$already" == "1" ]; then
    msg fish 'Already set up'
  else
    msg fish 'Setting up'
    cat << EOF >> ~/.config/fish/config.fish

# Prompt Messages
function on
  function pmsg --on-event fish_prompt
    $BIN_DIR/pmsg
  end
  function off
    functions -e pmsg
  end
end
# Enable prompt messages if on the right host and not over ssh
if [ (hostname) = "$HOSTNAME" ]; and not count \$SSH_TTY > /dev/null; on; end
EOF
  fi
fi

echo -e "\nPlease edit ~/$USER_CONF_DIR/time.conf and restart your shell.\n"
