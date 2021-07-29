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

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
#
# Via https://github.com/junegunn/fzf/wiki/examples#processes
#
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf --preview-window down:3:wrap -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf --preview-window down:3:wrap -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fbr - checkout git branch
#
# Adapted from:
#
# https://github.com/junegunn/fzf/wiki/examples#git
#
#
fbr() {
  local branches branch
  local query=$1
  local opts="--cycle +m -e --color=spinner:233,info:233 --select-1 --exit-0 --preview-window down:10 --height 50%"
  if ! [[ -z "${query// }" ]] ; then
      opts="$=opts -q ${query}"
  fi
  branches=$(git branch) &&
    branch=$(echo "$branches" | fzf "$=opts" --preview 'git --no-pager log --oneline --decorate --graph -n10 {1}') &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

alias sb=fbr
# Quickly switch to main (if it exists) or master
sbm() {
    if git for-each-ref --shell --format='%(refname)' refs/heads/ | grep -q main; then
        fbr main
    else
        fbr master
    fi
}