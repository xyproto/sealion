# Promptmessages

Display messages at the ZSH prompt at certain time intervals during the day.

## Goal

Help you remember stuff during the day, by reminding you directly at the prompt in certain customizable time intervals.

## Installation

### Requirements

* Python 3
* zsh

### As a user

* Install the executable and configuration file to `~/.pms`:

```
install -Dm755 pms ~/.pms/pms`
install -Dm755 time.example.conf ~/.pms/time.conf
```

* Edit `~/.pms/time.conf` to your liking.

* Add the following to your `~/.zshrc`:

    if [ $HOST = work_pc ] && [ ! -n "$SSH_TTY" ]; then
      precmd() { $HOME/.pms/pms }
    fi

* Change `work_pc` to whatever the hostname of your work pc is.

* Check that `~/.pms/pms` outputs messages as expected.

## Features and limitations

* `time.conf` needs to follow the existing format strictly (using `:` and `-` at the appropriate places) or there will be errors.
* Comments in `time.conf` are allowed, as long as they are single-line comments starting with `#`.

## General Info

* Version: 0.1
