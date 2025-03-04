HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt histignoredups
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# set ls colors
if ls --color > /dev/null 2>&1; then
    export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

alias findgrep='find . -type f -print0 | xargs -r0 grep -Hi $@'

# Allow Ctrl-z to toggle between suspend and resume
fancy-ctrl-z () {
    bg
    zle redisplay
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# fzf binding
if [ -e /usr/share/doc/fzf/examples/completion.zsh ]
then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
else
    echo "fzf not installed"
fi

# zsh autosuggestions
if [ -e /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]
then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6d6d6d" # dark grey
else
    echo "zsh-autosuggestions not installed!"
fi

# zsh syntax highlighting
if [ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "zsh-syntax-highlighting not installed!"
    echo "apt install zsh-syntax-highlighting"
fi

# CTRL-{RIGHT,LEFT} -> move one word forward backward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats "%s %r/%S %b (%a) %m%u%c"

# colors
# https://jonasjacek.github.io/colors/
WHITE="%F{15}"
DEEPSKYONE="%F{39}"
CHARTREUSETWO="%F{112}"
SKYBLUEONE="%F{117}"
DARKORANGE="%F{208}"
REDTHREE="%F{160}"
GOLDONE="%F{220}"
LIGHTGOLDENRODTWO="%F{222}"
GREENTHREE="%F{40}"
STEELBLUEONE="%F{81}"

# prompt
#precmd() { print "ret: $?" }
#precmd() { print "ret: $?"; vcs_info }
NEWLINE=$'\n'
USERNAME="%n"
AT="${WHITE}at"
HOSTNAME="${REDTHREE}%m"
IN="${WHITE}in"
DIR="${GREENTHREE}%1~"
COMMAND="${WHITE}${NEWLINE}-> "
VENV="(`basename \"$VIRTUAL_ENV\"`)"
DEFAULT_PROMPT="${DARKORANGE}${USERNAME} ${AT} ${HOSTNAME} ${IN} ${DIR}"
setopt prompt_subst
precmd() {
    vcs_info
    if [[ -n $VIRTUAL_ENV ]]; then
        PRE_PROMPT="(`basename \"$VIRTUAL_ENV\"`) ${WHITE}%(?..%B(%?%) %b)"
    else
        PRE_PROMPT="${WHITE}%(?..%B(%?%) %b)"
    fi
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # vcs_info found something (the documentation got that backwards
        # STATUS line taken from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${WHITE}on branch ${STEELBLUEONE}${vcs_info_msg_0_}${WHITE}got ${DEEPSKYONE}changes ${COMMAND}'
        else
            PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${WHITE}on branch ${STEELBLUEONE}${vcs_info_msg_0_}${WHITE}got no changes ${COMMAND}'
        fi
    else
        # nothing from vcs_info
        PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${COMMAND}'
    fi
}

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
