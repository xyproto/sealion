# Manual Setup

This should not normally be needed, since `prem-setup` handles this.

### Bash setup

* Add the following to your `~/.bashrc`:

```bash
# Prompt Reminder
on() {
  export PROMPT_COMMAND="/usr/bin/prem"
  off() { unset PROMPT_COMMAND; }
}

# Enable prompt messages if on the right host and not over ssh
[ $HOSTNAME = "work_pc" ] && [ ! -n "$SSH_TTY" ] && on || true
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Fish setup

* Add the following to your `~/.config/fish/config.fish`:

```fish
# Prompt Reminder
function on
  function prem --on-event fish_prompt
    /usr/bin/prem
  end
  function off
    functions -e prem
  end
end

# Enable prompt messages if on the right host and not over ssh
if [ (hostname) = "work_pc" ]; and not count $SSH_TTY > /dev/null; on; end
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Zsh setup

* Add the following to your `~/.zshrc`:

```zsh
# Prompt Reminder
on() {
  precmd() { /usr/bin/prem }
  off() { unset -f precmd }
}

# Enable prompt messages if on the right host and not over ssh
[ "$HOST" = "work_pc" ] && [ ! -n "$SSH_TTY" ] && on || true
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.
