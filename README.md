# The Sea Lion Prompt Reminder

Be reminded about things that happen daily, such as lunch, by messages on the command line, directly after your prompt.

The message is only displayed in certain time-intervals, not all the time.

## Quick installation

    sudo make install
    sealion-setup

## Requirements

* Python 3
* One or more of: `bash`, `fish` and `zsh`.

### User installation

* Run `sealion-setup`, which will do the following:
  * Place a script in `~/.config/sealion/sealion`, or upgrade an existing script.
  * Place the configuration in `~/.config/sealion.conf`. Will not modify existing configuration.
  * Add a few lines for setting up `sealion` to the bash, zsh or fish configuration files, if not already added. This includes the `on` and `off` shell functions for turning the prompt messages on or off.
* Edit `~/.config/sealion.conf` to your liking and restart your shell.

You might need to copy the `sealion` script into `~/.config/sealion` as well, for now.

### Test that it works

* Typing `off` or `on` should disable or enable the prompt notification.

## Features and limitations

* `sealion.conf` needs to follow the existing format strictly (using `:` and `-` at the appropriate places) or there will be errors.
* Comments in `sealion.conf` are allowed, as long as they are single-line comments starting with `#`.
* If a description in `sealion.conf` contains `%m`, it will be replaced with the number of minutes left when outputting the message.
* If the `TERM` environment variable contains `color`, the output message will be in color.

## For watching the notifications continuously

Simple case:

```sh
watch sealion
```

For watching the notifications continuously in a terminal window (updated every 5 seconds, no title, highlighted diff):

```sh
watch --color --differences --no-title --interval 5 sealion
```

# Manual Setup

This should not normally be needed, since `sealion-setup` handles this per user.

### Bash setup

* Add the following to your `~/.bashrc`:

```bash
# Sea Lion Prompt Reminder
on() {
  export PROMPT_COMMAND="/usr/bin/sealion"
  off() { unset PROMPT_COMMAND; }
}

# Enable prompt messages if on the right host and not over ssh
[ $HOSTNAME = "work_pc" ] && [ ! -n "$SSH_TTY" ] && on || true
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Fish setup

* Add the following to your `~/.config/fish/config.fish`:

```fish
# Sea Lion Prompt Reminder
function on
  function sealion --on-event fish_prompt
    /usr/bin/sealion
  end
  function off
    functions -e sealion
  end
end

# Enable prompt messages if on the right host and not over ssh
if [ (hostname) = "work_pc" ]; and not count $SSH_TTY > /dev/null; on; end
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Zsh setup

* Add the following to your `~/.zshrc`:

```zsh
# Sea Lion Prompt Reminder
on() {
  precmd() { /usr/bin/sealion }
  off() { unset -f precmd }
}

# Enable prompt messages if on the right host and not over ssh
[ "$HOST" = "work_pc" ] && [ ! -n "$SSH_TTY" ] && on || true
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

## General Info

* Version: 2.0.0
* License: MIT
* Author: Alexander F. Rødseth &lt;xyproto@archlinux.org&gt;
