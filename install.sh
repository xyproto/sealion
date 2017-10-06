#!/bin/sh

echo '----------------------------------'
echo 'Promptmessages installation script'
echo '----------------------------------'

TARGET_DIR=~/.config/pmsg

# Install $TARGET_DIR/pmsg
if [ -x $TARGET_DIR/pmsg ]; then
  # Only upgrade the executable if the files differ
  diff -q pmsg $TARGET_DIR/pmsg 2>&1 1>/dev/null && echo 'pmsg was already installed' || install -Dm755 pmsg $TARGET_DIR/pmsg
else
  echo "Installing $TARGET_DIR/pmsg"
  install -Dm755 pmsg $TARGET_DIR/pmsg
fi

# Install $TARGET_DIR/time.conf
if [ ! -f $TARGET_DIR/time.conf ]; then
  echo "Installing $TARGET_DIR/time.conf"
  install -Dm644 time.example.conf $TARGET_DIR/time.conf
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
  precmd() { $TARGET_DIR/pmsg }
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
    echo 'bash was already set up'
  else
    echo 'setting up bash'
    cat << EOF >> ~/.bashrc

# Prompt Messages
on() {
  export PROMPT_COMMAND="$TARGET_DIR/pmsg"
  off() { unset PROMPT_COMMAND; }
}
# Enable prompt messages if on the right host and not over ssh
[ \$HOSTNAME = "$HOSTNAME" ] && [ ! -n "\$SSH_TTY" ] && on
EOF
  fi
fi

# Set up fish, if not already set up
if [ -f ~/.config/fish/config.fish ]; then
  already=0
  grep -q -F 'function pmsg --on-event fish_prompt' ~/.config/fish/config.fish && already=1
  if [ "$already" == "1" ]; then
    echo 'fish was already set up'
  else
    echo 'setting up fish'
    cat << EOF >> ~/.config/fish/config.fish

# Prompt Messages
function on
  function pmsg --on-event fish_prompt
    $TARGET_DIR/pmsg
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


echo '----------------------------------'
echo "Now edit $TARGET_DIR/time.conf and restart your shell."
