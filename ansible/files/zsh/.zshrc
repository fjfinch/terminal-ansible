# PERFORMANCE CHECK
#zmodload zsh/zprof
#start="$(date +%s%N)"

# Hide EOL sign (%) in shell
#PROMPT_EOL_MARK=""

# Don't consider certain characters part of the word
WORDCHARS="${WORDCHARS//\/}"

# Keybindings
bindkey '^[[3;5~' kill-word		# ctrl + del (remove word right)
bindkey '^[[1;5C' forward-word		# ctrl + -> (go word right)
bindkey '^[[1;5D' backward-word		# ctrl + <- (go word left)

# History configurations
HISTFILE=~/.zsh_history			# path/location of the history file
HISTSIZE=5000				# number of commands that are in memory
SAVEHIST=5000				# number of commands that are stored from memory to file
setopt INC_APPEND_HISTORY		# write commands immediately from memory to file
setopt EXTENDED_HISTORY			# add timestamp of commands in file

# Grey auto-suggestions based on history (and other) - zsh-autosuggestions
#   is-at-least
#   add-zsh-hook
#   (anon)
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Specifying zsh options
setopt interactivecomments		# allow comments in interactive mode
setopt magicequalsubst			# enable filename expansion for arguments of the form ‘anything=expression’
setopt glob_dots			# show hidden files in output & tab completion
setopt promptsubst			# enable command substitution in prompt

if [ -f ~/.zsh/gitstatus/gitstatus.plugin.zsh ]; then
    . ~/.zsh/gitstatus/gitstatus.plugin.zsh
fi

# Update time & git status in prompt every second
TMOUT=1
TRAPALRM() {
    #bracketed-paste
    if [[ "${WIDGET}" != "expand-or-complete" && "${WIDGET}" != '*zle-line-pre-redraw' ]]; then  # disable updating (blanking) interactive tapcompletion dropdown
        update_prompt
        zle reset-prompt
    fi
}

# Colored prompt with prompt-expansion
update_prompt() {
    emulate -L zsh
    typeset -g  GITSTATUS_PROMPT=''

    gitstatus_query 'MY' || return 1
    if [[ "${VCS_STATUS_RESULT}" == 'ok-sync' ]]; then

        local p

        p+="${VCS_STATUS_LOCAL_BRANCH}"
        (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ⇣${VCS_STATUS_COMMITS_BEHIND}"
        (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
        (( VCS_STATUS_COMMITS_AHEAD  )) && p+="⇡${VCS_STATUS_COMMITS_AHEAD}"
        (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
        (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
        (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
        (( VCS_STATUS_STASHES        )) && p+=" *${VCS_STATUS_STASHES}"
        [[ -n $VCS_STATUS_ACTION     ]] && p+=" ${VCS_STATUS_ACTION}"
        (( VCS_STATUS_NUM_CONFLICTED )) && p+=" !${VCS_STATUS_NUM_CONFLICTED}"
        (( VCS_STATUS_NUM_STAGED     )) && p+=" %B+%b${VCS_STATUS_NUM_STAGED}"
        (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" %B~%b${VCS_STATUS_NUM_UNSTAGED}"
        (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" %B?%b${VCS_STATUS_NUM_UNTRACKED}"

        GITSTATUS_PROMPT="(%b%F{208}${p}%b%F{242}) "
    fi

    PROMPT="%b%F{242}[%*] %B%F{160}%~ %b%F{242}${GITSTATUS_PROMPT}> %b%f"
}

#    (anon)
#    add-zsh-hook
#    gitstatus_start
#    gitstatus_stop
#    _gitstatus_clear
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
precmd_functions+=(update_prompt)

# Colored commands - zsh-syntax-highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white,underline     # UNKNOWN COMMAND
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan         # command -option
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan         # command --option
fi

# Colored output from some commands
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
export LESS_TERMCAP_mb=$'\E[1;31m'      # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'     # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'         # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'      # begin underline
export LESS_TERMCAP_ue=$'\E[0m'         # reset underline

# Interactive drop down menu for tab completion features
#   compinit
#   compaudit 2x
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'	# make search case insensitive
zstyle ':completion:*' list-prompt ''				# text when scrolling menu per page
zstyle ':completion:*' select-prompt ''				# text when interactive scrolling menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# colored auto tap completion

# Command-not-found - when command not found, shows if (similar) package exists
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# Pipx variable path
export PATH="$PATH:/home/${USER}/.local/bin"

# Aliases
alias history='history 0'
alias lla='ls -lA'
alias thm='sudo openvpn ~/Finch.ovpn'

# END PERFORMACE CHECK
#end="$(date +%s%N)"
#echo "$(((end-start)/1000000))ms"
#zprof

#: <<'END_COMMENT'
# END_COMMENT
