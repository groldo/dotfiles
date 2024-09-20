HISTFILE=~/.zsh_history
SAVEHIST=10000
setopt histignoredups
#
# Allow Ctrl-z to toggle between suspend and resume
fancy-ctrl-z () {
    bg
    zle redisplay
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# fzf binding
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

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
            PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${WHITE}on branch ${DEEPSKYONE}${vcs_info_msg_0_}CHANGES ${COMMAND}'
        else
            PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${WHITE}on branch ${STEELBLUEONE}${vcs_info_msg_0_}no changes ${COMMAND}'
        fi
    else
        # nothing from vcs_info
        PROMPT='${PRE_PROMPT}${DEFAULT_PROMPT} ${COMMAND}'
    fi
}
