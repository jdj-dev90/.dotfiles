# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[green]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
# stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Add in zsh plugins
zinit ice wait"1" lucid
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait"1" lucid
zinit light zsh-users/zsh-completions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit ice wait"1" lucid
zinit snippet OMZP::git
zinit ice wait"1" lucid
zinit snippet OMZP::sudo
zinit ice wait"1" lucid
zinit snippet OMZP::tmux
zinit ice wait"1" lucid
zinit snippet OMZP::archlinux
zinit ice wait"1" lucid
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${ZSH_VERSION}"
_comp_options+=(globdots)		# Include hidden files.

# Defer heavy init until after first prompt
autoload -Uz add-zsh-hook
typeset -a _zsh_deferred_cmds
_zsh_defer() {
    _zsh_deferred_cmds+=("$*")
}
_zsh_run_deferred() {
    local cmd
    for cmd in "${_zsh_deferred_cmds[@]}"; do
        eval "$cmd"
    done
    _zsh_deferred_cmds=()
    add-zsh-hook -d precmd _zsh_run_deferred
}
add-zsh-hook precmd _zsh_run_deferred

_zsh_defer 'compinit -C -d "$_compdump"'
_zsh_defer 'zinit cdreplay -q'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}



bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete
bindkey '^Y' autosuggest-accept

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '^@' 'tmux-splitter\n'

_zsh_defer 'source ~/.zsh_profile'

# NVIM app selector
vv() {
  select config in packer lazy
  do NVIM_APPNAME=nvim-$config nvim $@; break; done
}

# Run a command and copy command + output to clipboard
copyrun() {
    local cmd_str output exit_code payload
    cmd_str=${(qq)@}
    output="$("$@" 2>&1)"
    exit_code=$?
    print -r -- "$output"
    payload="> $cmd_str"$'\n'"$output"
    if [[ $exit_code -ne 0 ]]; then
        payload+=$'\n'"(exit $exit_code)"
    fi
    print -rn -- "$payload" | xclip -selection clipboard
    return $exit_code
}

# pnpm
export PNPM_HOME="/home/jordan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jordan/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jordan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
_zsh_defer 'if [ -f "/home/jordan/google-cloud-sdk/completion.zsh.inc" ]; then . "/home/jordan/google-cloud-sdk/completion.zsh.inc"; fi'

# Shell integrations
_zsh_defer 'eval "$(fzf --zsh)"'
_zsh_defer 'if [ -z "$DISABLE_ZOXIDE" ]; then eval "$(zoxide init --cmd cd zsh)"; fi'

# fnm
FNM_PATH="/home/jordan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jordan/.local/share/fnm:$PATH"
  _zsh_defer 'eval "$(fnm env --use-on-cd --shell zsh)"'
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
_zsh_defer 'eval "$(pyenv init - zsh)"'

# opencode
export PATH=/home/jordan/.opencode/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
