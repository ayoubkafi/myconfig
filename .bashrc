#neofetch

#c && neofetch --disable term_font  gpu icons theme model  --color_blocks off --colors 1 3 3 4 7 3 --ascii_distro Linux

#PS1="\[\033[0;32m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\033[0;34m\]\W\[\033[0;31m\] > \[\e[m\]"
# → | ❯ | >
PS1="\[\033[0;34m\]\W\[\033[0;32m\] → \[\e[m\]"

# Ayoub Alias
alias c='clear'
alias e='exit'
alias sp='sudo pacman'

alias l='ls -F --color=auto'
alias ls='ls --color=auto'
alias la='lsd -la --icon never'
alias ll='lsd -l --icon never'

alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias dmesg='dmesg --color=auto'

alias vim='nvim'
alias v='nvim'
alias r='ranger'
alias nc='ncmpcpp'
alias ccat='highlight --out-format=ansi --force'
alias n='nnn -Rd'

#-------- Color Manpages
export LESS_TERMCAP_mb=$'\E[01;31m'               # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'          # begin bold
export LESS_TERMCAP_md=$'\E[01;33m'								# begin bold
export LESS_TERMCAP_me=$'\E[0m'                   # end mode
export LESS_TERMCAP_se=$'\E[0m'                   # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'            # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                   # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m'         # begin underline
export LESS_TERMCAP_us=$'\E[04;36m'								# begin underline
#export MANPAGER="/usr/bin/most -s"                # color using most

# tab size
tabs -2

# vi mode
set -o vi

# gruvbox theme
. ~/.scripts/gruvbox/gruvbox_256palette_osx.sh
