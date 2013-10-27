#!/bin/bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Extra files I want to load
for file in ~/.{git_aliases}; do
  [ -r "$file" ] && source "$file"
done

# Naiad RC for work.
[ -f ~/src/users/darylr/.naiadrc ] && source ~/src/users/darylr/.naiadrc

unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "ProxyConfig Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If
if [ $(which brew) ]; then
  [ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion
else
  [ -f /etc/bash_completion ] && source /etc/bash_completion
fi

# Ruby Version Manager
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Node Version Manager
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
