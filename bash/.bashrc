# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)                                                                                                                                                                   
# for examples                                                                                                                                                                                                                               
                                                                                                                                                                                                                                             
# If not running interactively, don't do anything                                                                                                                                                                                            
[ -z "$PS1" ] && return                                                                                                                                                                                                                      
                                                                                                                                                                                                                                             
# don't put duplicate lines or lines starting with space in the history.                                                                                                                                                                     
# See bash(1) for more options                                                                                                                                                                                                               
HISTCONTROL=ignoreboth                                                                                                                                                                                                                       
                                                                                                                                                                                                                                             
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)                                                                                                                                                                        
# append to the history file, don't overwrite it                                                                                                                                                                                             
shopt -s histappend                                                                                                                                                                                                                          
HISTSIZE=1000                                                                                                                                                                                                                                
HISTFILESIZE=2000                                                                                                                                                                                                                            
                                                                                                                                                                                                                                             
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# set dot for numpad del
#setxkbmap -option '' -option kpdl:dot de

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

export GIT_PS1_SHOWSTASHSTATE=1

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (\[\e[0;32m\]%s\[\e[0m\])")\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (\[\e[0;32m\]%s\[\e[0m\])")\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if uname -a | grep -q 'x86_64'; then
  echo "I'm 64-bit"
  
  source /home/alves/software/artiminds/ros/devel/setup.bash 
  source /home/alves/software/artiminds/rviz/devel/setup.sh --extend
  source /home/alves/software/artiminds/moveit_stage1/devel/setup.sh --extend
  source /home/alves/software/artiminds/am-robots/devel/setup.sh --extend  
  source /home/alves/software/artiminds/moveit_stage2/devel/setup.sh --extend 
  
  alias .a='cd ~/software/artiminds/am-core/'
  alias .e='cd ~/software/artiminds/am-editor/'
  alias .m='cd ~/software/artiminds/moveit_stage2/src/moveit_ros/visualization/motion_planning_rviz_plugin'
  alias .r='roslaunch ur5_robotiq_moveit_config demo.launch' 
  alias .k='source ~/.bashrc_keba' 

  export inrop_DIR=/home/alves/software/artiminds/am-core/ros/cmake/ 
  
  export PATH=/home/alves/bin/:/home/alves/software/local/lib/xacro/:/home/alves/software/local/bin/:/home/alves/software/artiminds/am-hal/ur/ros/devel/lib/ur_publisher/:/home/alves/software/artiminds/build/am-hal/atidriver/:/home/alves/software/artiminds/moveit_stage2/devel/lib/am-robot_configurator:$PATH
  export LD_LIBRARY_PATH=/home/alves/software/local/lib/:/home/alves/software/libraries/ros/devel/lib:$LD_LIBRARY_PATH
else
  echo "I'm 32-bit"
    
  source /home/alves/software/devel-32/ros/devel/setup.bash 
  source /home/alves/software/devel-32/rviz/devel/setup.sh --extend
  source /home/alves/software/devel-32/moveit_stage1/devel/setup.sh --extend
  source /home/alves/software/devel-32/am-robots/devel/setup.sh --extend  
  source /home/alves/software/devel-32/moveit_stage2/devel/setup.sh --extend
 
  alias .a='cd ~/software/artiminds/am-core/'
  alias .e='cd ~/software/artiminds/am-editor/'
  alias .m='cd ~/software/artiminds/moveit_stage2/src/moveit_ros/visualization/motion_planning_rviz_plugin'
  alias .r='roslaunch ur5_robotiq_moveit_config demo.launch' 
  alias .k='source ~/.bashrc_keba' 

  export inrop_DIR=/home/alves/software/devel-32/am-core/ros/cmake/

  
  export PATH=/home/alves/software/devel-32/local/lib/xacro/:/home/alves/software/devel-32/local/bin/:/home/alves/software/devel-32/am-hal/ur/ros/devel/lib/ur_publisher/:/home/alves/software/devel-32/build/am-hal/atidriver/:/home/alves/software/artiminds/moveit_stage2/devel/lib/am-robot_configurator:$PATH
  export LD_LIBRARY_PATH=/home/alves/software/devel-32/local/lib/:$LD_LIBRARY_PATH
fi

export PPROF_PATH=/usr/bin/google-pprof
export ROSCONSOLE_CONFIG_FILE=/home/alves/.ros/rosconsole.config
export ROS_MASTER_URI=http://localhost:11311

source /etc/enable-ccache.sh 

export SHELL=/bin/zsh
export LC_TIME=de_DE.UTF-8

export MariaDbConnector_ROOT_DIR=/home/alves/software/artiminds/mariadb-connector-c/

exec /bin/zsh -l
