# Prompt Reminder Messages

Display messages right before the prompt at certain time intervals during the day.

## Goal

Help you remember stuff during the day, by reminding you directly at the prompt in certain customizable time intervals.

## Installation

### Requirements

* Python 3
* bash, fish or zsh

### Asciicast

[![asciicast](https://asciinema.org/a/kdSeWSAxNzgRK8tKlrLT074uk.png)](https://asciinema.org/a/kdSeWSAxNzgRK8tKlrLT074uk)

### User installation

* Run `./install.sh`, which will do the following:
  * Place the script in `~/.config/promptmessage/promptmessage`, or upgrade an existing script.
  * Place the configuration in `~/.config/promptmessage/time.conf`. Will not modify existing configuration.
  * Set up bash and zsh, if not already set up.
  * This also includes the `on` and `off` shell functions for turning the prompt messages on or off.

* Edit `~/.config/promptmessage/time.conf` to your liking and restart your shell.

# Manual setup

Just running the install script should be enough to set up `promptmessage`. If you would rather set things up manually, here are the suggested configuration snippets for your shell:

### Bash setup

* Add the following to your `~/.bashrc`:

```
# Prompt Messages
on() {
  export PROMPT_COMMAND="/usr/bin/promptmessage"
  off() { unset PROMPT_COMMAND; }
}

# Enable prompt messages if on the right host and not over ssh
[ $HOSTNAME = "work_pc" ] && [ ! -n "$SSH_TTY" ] && on || true
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Fish setup

* Add the following to your `~/.config/fish/config.fish`:

```
# Prompt Messages
function on
  function promptmessage --on-event fish_prompt
    /usr/bin/promptmessage
  end
  function off
    functions -e promptmessage
  end
end

# Enable prompt messages if on the right host and not over ssh
if [ (hostname) = "work_pc" ]; and not count $SSH_TTY > /dev/null; on; end
```

* NOTE: Change `work_pc` to whatever the hostname of your work pc is.

### Zsh setup

* Add the following to your `~/.zshrc`:

```
# Prompt Messages
on() {
  precmd() { /usr/bin/promptmessage }
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

    watch promptmessage

For watching the notifications continuously in a terminal window (updated every 5 seconds, no title, highlighted diff):

    watch --color --differences --no-title --interval 5 promptmessage

## General Info

* Version: 0.8
