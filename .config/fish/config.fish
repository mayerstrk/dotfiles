if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

# Created by `pipx` on 2025-01-15 17:39:07
set PATH $PATH /Users/mstark/.local/bin
set -gx PATH ~/.local/bin $PATH

set -gx TERM xterm-256color

#fzf.fish configure keybindings
bind \co _fzf_search_directory

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/brew shellenv)"

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias git-fetch-parent "git name-rev --name-only (git rev-parse (git log --merges -1 --format=%H)^2) | sed 's/[\^~].*//'"
alias nuke-pycache "find . -type d -name "__pycache__" -exec rm -rf {} +"
command -qv nvim && alias vim nvim

function git-clean-branches
    set -l current (git branch --show-current)
    git for-each-ref --format='%(refname:short)' refs/heads \
        | grep -vFx -- $current \
        | xargs -r git branch -D
end

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# Set NVM directory
set -x NVM_DIR $HOME/.nvm

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# enable starship promt https://starship.rs/guide
starship init fish | source

# zoxide (smarter cd, replaces z). Import old history once: zoxide import --from z
command -q zoxide; and zoxide init fish | source

# PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# opencode
fish_add_path /Users/mstark/.opencode/bin

# pnpm
set -gx PNPM_HOME "/Users/mstark/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
