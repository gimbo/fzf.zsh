# fzf configuration

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="\
  --border=none
  --color=hl:#f94e4e,hl+:#ffff00,gutter:-1
  --info=inline-right
  --layout=reverse
  "

# Quoting the docs: --select-1 automatically selects the item if there's only
# one so that you don't have to press enter key.  Likewise, --exit-0
# automatically exits when the list is empty.
local fzf_singleton_opts="--select-1 --exit-0"



# Key bindings for command-line

source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# Ctrl-T mode — paste selected items onto command line
export FZF_CTRL_T_COMMAND="fd"
export FZF_CTRL_T_OPTS="
  $fzf_singleton_opts
  --filepath-word
  --preview='bat -n --color=always {}'
  --bind='ctrl-/:change-preview-window(down|hidden|)'
  "

# Ctrl-R mode — history search
export FZF_CTRL_R_OPTS="\
  --height=~30%
  --layout=default
  --preview='echo {}'
  --preview-window='right,50%,border-left,wrap,<60(down,10%,border-top,wrap)'
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header='⌃R relevance/chronological • ⌃Y to clipboard • ⌃/ preview'
  --header-first
  "

# Alt-C mode — cd into selected folder; probably prefer zoxide or Alfred.
export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix"
export FZF_ALT_C_OPTS="\
  $fzf_singleton_opts
  --filepath-word
  --preview 'tree -C {}'
  "



# Fuzzy completion

# I disable this as I prefer the Aloxaf/fzf-tab plugin
# source "$(brew --prefix)/opt/fzf/shell/completion.zsh"



# My fzf extras

autoload -Uz fkill fbr sbm
alias sb=fbr
