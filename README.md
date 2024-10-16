# Sea Lion Lunch Reminder

<img src="img/sealion.jpg" width="330" align="right">

Be reminded to have lunch, directly in your prompt.

Messages are displayed in configurable time-intervals.

### Example configuration

`~/.config/sealion.conf`

```c
11:00 - 11:20 : lunch 11:20, in %m minutes
```

This will add a prompt reminder from 11:00 to 11:20 with the message "lunch 11:20, in N minutes", where N is the number of minutes left.

### Quick installation

System installation:

    git clone https://github.com/xyproto/sealion
    cd sealion
    sudo make install
    
 User setup:   
    
    sealion-setup

## Configuration

<img src="https://i0.wp.com/francesbell.com/wp-content/uploads/2015/02/sealion-cartoon.png" width="512" align="right">

* `sealion.conf` needs to follow the existing format (using `:` and `-` in the appropriate places).
* Comments in `sealion.conf` are allowed, as long as they are single-line comments starting with `#`.
* If a description in `sealion.conf` contains `%m`, it will be replaced with the number of minutes left when outputting the message.

Type `on` or `off` to enable or disable Sea Lion for the current shell session.


### User setup on a system where Sea Lion has already been installed

    sealion-setup

## Requirements

* Python 3
* `bash`, `fish` or `zsh`.

## Alternative use: Run watch in a separate terminal emulator

Simple case:

```sh
watch sealion
```

For updating every 5 seconds, with no title and highlighting any differences:

```sh
watch --color --differences --no-title --interval 5 sealion
```

## Manual Setup

The following is not normally needed, since `sealion-setup` handles this per user, but it helps to explain what is being set up by `sealion-setup`:

### Manual Bash setup

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

* NOTE: Change `work_pc` to whatever the hostname of your work PC is.

### Manual Fish setup

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

* NOTE: Change `work_pc` to whatever the hostname of your work PC is.

### Manual Zsh setup

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

* NOTE: Change `work_pc` to whatever the hostname of your work PC is.

## General Info

* Version: 2.0.1
* License: MIT
* Author: Alexander F. Rødseth &lt;xyproto@archlinux.org&gt;
