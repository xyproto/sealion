# Prompt Reminder

Be reminded about things that happen daily, such as lunch, by messages on the command line, directly after your prompt.

The message is only displayed in certain time-intervals, not all the time.

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

You might need to copy the `prem` script into `~/.config/prem` as well, for now.

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

* Version: 1.1.0
* License: MIT
* Author: Alexander F. Rødseth &lt;xyproto@archlinux.org&gt;
