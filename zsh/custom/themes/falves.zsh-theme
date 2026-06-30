# FAlves Theme
# Shamelessly hacked from kafeitu and Sunrise

ZSH_THEME_GIT_PROMPT_AHEAD=" ↑"
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"
ZSH_THEME_GIT_PROMPT_DIVERGED=" ↯"

function _falves_remote_status() {
  local index remote_st
  index=$(command git status --porcelain -b 2>/dev/null)
  remote_st=""
  if echo "$index" | grep -q '^## .*ahead.*behind'; then
    remote_st="%{$fg_bold[yellow]%}${ZSH_THEME_GIT_PROMPT_DIVERGED}"
  else
    if echo "$index" | grep -q '^## .*ahead'; then
      remote_st="%{$fg_bold[blue]%}${ZSH_THEME_GIT_PROMPT_AHEAD}"
    fi
    if echo "$index" | grep -q '^## .*behind'; then
      remote_st="${remote_st}%{$fg_bold[yellow]%}${ZSH_THEME_GIT_PROMPT_BEHIND}"
    fi
  fi
  echo "$remote_st"
}

function _falves_branch_color() {
  if [ "$1" = "develop" ]; then
    echo "%{$fg_bold[green]%}"
  elif [ "$1" = "master" ] || [ "$1" = "main" ]; then
    echo "%{$fg_bold[cyan]%}"
  else
    echo "%{$fg_bold[magenta]%}"
  fi
}

# Update git prompt variables before each prompt draw so the literal
# $(git_prompt_info) in PROMPT picks them up with the right colors.
function _falves_precmd() {
  local branch branch_color
  branch=$(git symbolic-ref --short -q HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    branch_color=$(_falves_branch_color "$branch")
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[blue]%}(${branch_color}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="$(_falves_remote_status)%{$fg_no_bold[blue]%})%{$reset_color%} "
    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✗"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
  else
    ZSH_THEME_GIT_PROMPT_PREFIX=""
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""
  fi
}

add-zsh-hook precmd _falves_precmd

function _ret_status() {
  local privilege="%(!.#.$)"
  echo "%(?:%{$fg_bold[green]%}${privilege} :%{$fg_bold[red]%}${privilege} )"
}

function _return_code() {
  echo "%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"
}

RPS1='$(_return_code)'
PROMPT='%{$fg_no_bold[green]%}%n%{$fg_bold[yellow]%}@%{$fg_no_bold[red]%}%m %{$fg_no_bold[cyan]%}${PWD/#$HOME/~} $(git_prompt_info)$(_ret_status)%{$reset_color%}'
