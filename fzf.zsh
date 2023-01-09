# Setup fzf
# ---------

# Auto-completion
# ---------------
#
# I disable this because I use the zsh-autosuggestions zsh plugin
# [[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."

export FZF_DEFAULT_OPTS="--color=hl:#f94e4e,hl+:#ffff00 --height 40% --reverse"

# Quoting the docs:
# --select-1 automatically selects the item if there's only one so that you don't have to press enter key.
# Likewise, --exit-0 automatically exits when the list is empty.
# These options are also useful in FZF_ALT_C_OPTS.
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --select-1 --exit-0"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --select-1 --exit-0"

# Quoting the docs:

# Commands that are too long are not fully visible on screen. We can use --preview option to display the full command on
# the preview window. In the following example, we bind ? key for toggling the preview window.
FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS  --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

autoload -Uz fkill fbr sbm
alias sb=fbr
