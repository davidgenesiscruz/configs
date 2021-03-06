#!/bin/zsh
setopt NULL_GLOB

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_192.jdk/Contents/Home"
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export LSCOLORS="gxfxcxdxbxegedabagacad"

alias ll="ls -laAG"
alias ls="ls -aAG"
alias preview="qlmanage -p"
alias reload="source ~/.zprofile"
alias clearCache="rm -rf /Library/Caches/* /Library/Logs/* ~/Library/Caches/* ~/Library/Logs/*"
alias rm="rm -v"
alias mv="mv -v"
alias cp="cp -v"

toMp3() {
    ffmpeg -i "$1" -vn -c:a libmp3lame -b:a 256k "${1%.*}.mp3"
}

eval "$(nodenv init -)"

#Welcome Screen
function is_dirty_git() {
    git add .
    git diff-index --quiet HEAD -- || return 0
    return 1
}

function update_configs() {
    echo "Updating configurations..."
    if is_dirty_git
    then
        git diff
        git commit --int || git push
    fi
    cd -
}    

function startUp() {
    echo "Hi "$USER"! What do you want me to do today?"
    echo "1.) Show agenda"
    echo "2.) Show git"
    echo "3.) Run Tasker"
    echo "0.) Nothing"
    read choice

    case $choice in
        1) while true;do clear;agenda;sleep 60;done;;
        2) . /usr/local/bin/whichgit;while true;do clear;gitstart;sleep 60;done;;
        3) ~/Desktop/tasker 30;;
    esac

    clear
}

#TMUX
function is_exists() { type "$1" > /dev/null 2>&1; return $2; }

function is_screen_running() {
    if [ -n "$STY" ]
        then return 0
        else return 1
    fi
}

function is_tmux_running() {
    if [ -n "$TMUX" ]
        then return 0
        else return 1
    fi
}

function is_interactive_shell_started() {
    if [ -n "$PS1" ]
        then return 0
        else return 1
    fi
}

function is_ssh_connected() {
    if [ -n "$SSH_CONNECTION" ]
        then return 0
        else return 1
    fi
}

function attach_tmux_session() {
    if is_screen_running || is_tmux_running
    then
        ! is_exists 'tmux' && return 1
        if is_tmux_running
        then
            echo "${fgbold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fgbold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fgbold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fgbold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fgbold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running
            then echo "Screen is running."
        fi
    else
        if is_interactive_shell_started && ! is_ssh_connected
        then
            if ! is_exists 'tmux'
            then
                echo "Error; tmux command not found" 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'
            then
                tmux list-sessions
                echo -n "Attach tmux session? (y/n/num) "
                read choice

                if [[ "$choice" =~ ^[Yy]$ ]] || [[ "$choice" == "" ]]
                then
                    tmux attach-session
                elif [[ "$choice" =~ ^[0-9]+$ ]]
                then
                    tmux attach -t "$choice"
                fi

                if [ $? -eq 0 ]
                then
                    echo "$(tmux -V) attached session"
                    return 0
                fi
            fi

        tmux new-session && echo "tmux created new session"
        fi
    fi
}

if is_tmux_running
    then echo #update_configs;echo;startUp
    else attach_tmux_session
fi

