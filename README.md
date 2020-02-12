# Prompt Reminder

Be reminded about things that happen daily, such as lunch, by messages on the command line, directly after your prompt.

## Quick installation

    sudo install -Dm755 prem-setup /usr/bin/prem-setup
    sudo install -Dm755 prem /usr/bin/prem

## Requirements

* Python 3
* `bash`, `fish` or `zsh`.

### User installation

* Run `prem-setup`, which will do the following:
  * Place a script in `~/.config/prem/prem`, or upgrade an existing script.
  * Place the configuration in `~/.config/prem/time.conf`. Will not modify existing configuration.
  * Set up bash and zsh, if not already set up.
  * This also includes the `on` and `off` shell functions for turning the prompt messages on or off.

* Edit `~/.config/prem/time.conf` to your liking and restart your shell.

## Manual setup

Just running the install script should be enough to set up `prem`. If you would rather set things up manually, here are the suggested configuration snippets for your shell:

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

### Test that it works

* Typing `off` or `on` should disable or enable the prompt notification.

## Features and limitations

* `time.conf` needs to follow the existing format strictly (using `:` and `-` at the appropriate places) or there will be errors.
* Comments in `time.conf` are allowed, as long as they are single-line comments starting with `#`.
* If a description in `time.conf` contains `%m`, it will be replaced with the number of minutes left when outputting the message.
* If the `TERM` environment variable contains `color`, the output message will be in color.

## For watching the notifications continuously

Simple case:

```sh
watch prem
```

For watching the notifications continuously in a terminal window (updated every 5 seconds, no title, highlighted diff):

```sh
watch --color --differences --no-title --interval 5 prem
```

## General Info

* Version: 1.0.0
* License: MIT
* Author: Alexander F. Rødseth &lt;xyproto@archlinux.org&gt;

