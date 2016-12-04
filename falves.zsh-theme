# FAlves Theme
# Shamelessly hacked from kafeitu and Sunrise

# Color shortcuts
R=$fg_no_bold[red]
Rb=$fg_bold[red]
C=$fg_no_bold[cyan]
Cb=$fg_bold[cyan]
G=$fg_no_bold[green]
Gb=$fg_bold[green]
M=$fg_no_bold[magenta]
Mb=$fg_bold[magenta]
Y=$fg_no_bold[yellow]
Yb=$fg_bold[yellow]
B=$fg_no_bold[blue]
Bb=$fg_bold[blue]
RESET=$reset_color

# Return status as $ or #
local privilege="%(!.#.$)"
local ret_status="%(?:%{$Gb%}$privilege :%{$Rb%}$privilege )"

# Return error code on failure
local return_code="%(?..%{$Rb%}%? ←%{$RESET%})"
RPS1="${return_code}"

# Format for remote_status()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$Bb%} ↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$Y%} ↓"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$Y%} ≠"

# Remote status for git
remote_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead* .*behind' &> /dev/null); then
    STATUS=""
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}

#Assigns a color to a given branch name
function color_from_branch_name()
{
        if [ "$1" = "develop" ]; then
                echo "%{$Gb%}"
        elif [ "$1" = "master" ]; then
                echo "%{$Cb%}"
        else
                echo "%{$Mb%}"
        fi
} 

# Custom git prompt (match branch colors from listing tool)
function custom_git_prompt() {
	# Define custom branch color
	local branch=$(git symbolic-ref --short -q HEAD 2> /dev/null) || branch="??"
	
	local branch_color=$(color_from_branch_name "$branch")
	# Git info
	ZSH_THEME_GIT_PROMPT_PREFIX="%{$B%}(${branch_color}"
	ZSH_THEME_GIT_PROMPT_SUFFIX="$(remote_status)%{$B%})%{$RESET%} "
	ZSH_THEME_GIT_PROMPT_DIRTY=" %{$Y%}X"
	ZSH_THEME_GIT_PROMPT_CLEAN=""
	echo "$(git_prompt_info)"
}

# Full prompt
PROMPT='%{$G%}%n%{$Yb%}@%{$R%}home %{$C%}${PWD/#$HOME/~} $(custom_git_prompt)${ret_status}%{$RESET%}'

