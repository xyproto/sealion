#!/bin/sh

echo '----------------------------------'
echo 'Promptmessages installation script'
echo '----------------------------------'

# Install ~/.pms/pms
if [ -x ~/.pms/pms ]; then
  # Only upgrade the executable if the files differ
  diff -q pms ~/.pms/pms 2>&1 1>/dev/null && echo 'pms was already installed' || install -Dm755 pms ~/.pms/pms
else
  echo 'Installing ~/.pms/pms'
  install -Dm755 pms ~/.pms/pms
fi

# Install ~/.pms/time.conf
if [ ! -f ~/.pms/time.conf ]; then
  echo 'Installing ~/.pms/time.conf'
  install -Dm644 time.example.conf ~/.pms/time.conf
fi

# Set up zsh, if not already set up
if [ -f ~/.zshrc ]; then
  already=0
  grep -q -F 'precmd() {' ~/.zshenv && already=1
  grep -q -F 'precmd() {' ~/.zshrc && already=1
  if [ "$already" == "1" ]; then
    echo 'zsh was already set up'
  else
    echo 'setting up zsh'
    cat << EOF >> ~/.zshrc

# Prompt Messages
on() {
  precmd() { \$HOME/.pms/pms }
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
  grep -q PROMPT_COMMAND= ~/.bash_profile && already=1
  grep -q PROMPT_COMMAND= ~/.bashrc && already=1
  if [ "$already" == "1" ]; then
    echo 'bash was already set up'
  else
    echo 'setting up bash'
    cat << EOF >> ~/.bashrc

# Prompt Messages
on() {
  export PROMPT_COMMAND="\$HOME/.pms/pms"
  off() { unset PROMPT_COMMAND; }
}
# Enable prompt messages if on the right host and not over ssh
[ \$HOSTNAME = "$HOSTNAME" ] && [ ! -n "\$SSH_TTY" ] && on
EOF
  fi
fi

echo '----------------------------------'
echo 'Now edit ~/.pms/time.conf and restart your shell.'
