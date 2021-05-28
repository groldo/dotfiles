setopt histignoredups

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
setopt prompt_subst
precmd() {
    print "ret: $?";
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # vcs_info found something (the documentation got that backwards
        # STATUS line taken from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            PROMPT='${DARKORANGE}${USERNAME} ${AT} ${HOSTNAME} ${IN} ${DIR} ${WHITE}on branch ${DEEPSKYONE}${vcs_info_msg_0_}CHANGES ${COMMAND}'
        else
            PROMPT='${DARKORANGE}${USERNAME} ${AT} ${HOSTNAME} ${IN} ${DIR} ${WHITE}on branch ${STEELBLUEONE}${vcs_info_msg_0_}no changes ${COMMAND}'
        fi
    else
        # nothing from vcs_info
        PROMPT='${DARKORANGE}${USERNAME} ${AT} ${HOSTNAME} ${IN} ${DIR} ${COMMAND}'
    fi
}
