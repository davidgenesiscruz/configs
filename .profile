#!/bin/bash
export HOMEBREW_CASK_OPTS="--appdir=/Applications/"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home/"
export MAVEN_HOME="/usr/local/apache-maven/apache-maven-3.3.3/"
export PATH="$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:/usr/local/mysql/bin:$HOME/.rbenv/bin:/Applications/Xcode.app/Contents/Developer/usr/share/xcs/Redis/bin/:$HOME/Documents/dev/anaconda3/bin/"
export DAVIDE="$HOME/Documents/dev/careertrek/workspace/careertrek/"
export DYNAMO="$HOME/Documents/dev/careertrek/careertrek-tool/dynamo-trek/"
export MAIHAMA="$HOME/projects/training/workspace/hands-on/dbflute-hands-on/dbflute_maihamadb/"
export NIPPO="$HOME/Documents/日報/"
export VAGRANT="$HOME/Documents/dev/careertrek/careertrek-tool/ct-vagrant/"


## Docker初期化
function isDockerRunning() {
	if [[ $(docker-machine status) == Running ]]
		then return 0
		else return 1
	fi
}
function dockerProcessCount() {
	return $(( $(docker ps | wc -l) ))
}
if ! isDockerRunning
then
	docker-machine start
fi
if (( dockerProcessCount <= 0 ))
then
	cd ~/Documents/dev/careertrek/workspace/careertrek/davide-docker/
	eval $(docker-machine env default)
	docker-compose up -d
	cd - > /dev/null
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias alignGeek="osascript ~/Documents/dev/geektools/.alignGeeklets.scpt"
alias alignGeekSmall="osascript ~/Documents/dev/geektools/.alignGeekletsSmall.scpt"
alias editProf="cd $HOME/Documents/dev/config/;vim .profile;cp .profile $HOME;cd - > /dev/null"
alias goDavide="cd $DAVIDE"
alias goDemotrek="ssh -i $HOME/.ssh/dev_id_rsa -p 22373 david.genesis.cruz@54.238.137.15"
alias goDocker="cd $DAVIDE/davide-docker"
alias goDynamo="cd $DYNAMO;java -jar dynamo-trek.jar"
alias goLocalDb="mysql -h 192.168.99.100 davide  -uroot -p"
alias goNippo="cd $NIPPO"
alias goVagrant="cd $VAGRANT"
alias ll="ls -laG"
alias ls="ls -aG"
alias reload="source ~/.profile"
alias shutdown="echo 'KbN=fhKW' | sudo -S shutdown -h now"
alias startVagrant="cd $VAGRANT;vagrant up;vagrant ssh;cd - > /dev/null"
alias stopVagrant="cd $VAGRANT;vagrant halt;cd - > /dev/null"
alias startDynamo="cd $DYNAMO;npm start;cd - > /dev/null"
alias stopDynamo="cd $DYNAMO;npm stop;cd - > /dev/null"
alias time="date '+%H:%M'"
alias viewProf="less ~/Documents/dev/config/.profile"

function edit() { sudo vim /usr/local/bin/$@; }
function startUp() {
	echo "Good morning! What do you want me to do today?"
	echo "1.) Show git"
	echo "0.) Nothing"
	read choice
	
	case $choice in
		1 ) cd $DAVIDE;gitstart;;
		* ) clear;docker ps;;
	esac
}

## TMUX
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() {
	if [[ $OSTYPE == darwin* ]]
		then return 0
		else return 1
	fi
}
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
function is_screen_or_tmux_running() { is_screen_running || is_tmux_running; }
function shell_has_started_interactively() {
	if [ -n "$PS1" ]
		then return 0
		else return 1
	fi
}
function is_ssh_running() {
	if [ -n "$SSH_CONECTION" ]
		then return 0
		else return 1
	fi
}
function tmux_automatically_attach_session() {
	if is_screen_or_tmux_running
	then
		! is_exists 'tmux' && return 1
		if is_tmux_running
		then
			echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
			echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
			echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
			echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
			echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
		elif is_screen_running; then
			echo "This is on screen."
		fi
	else
		if shell_has_started_interactively && ! is_ssh_running
		then
			if ! is_exists 'tmux'
			then
				echo 'Error: tmux command not found' 2>&1
				return 1
			fi
			
			if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'
			then
				# detached session exists
				tmux list-sessions
				echo -n "Tmux: attach? (y/N/num) "
				read
				if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]
				then
					tmux attach-session
					if [ $? -eq 0 ]
					then
						echo "$(tmux -V) attached session"
						return 0
					fi
				elif [[ "$REPLY" =~ ^[0-9]+$ ]]
				then
					tmux attach -t "$REPLY"
					if [ $? -eq 0 ]
					then
						echo "$(tmux -V) attached session"
						return 0
					fi
				fi
			fi
	
			if is_osx && is_exists 'reattach-to-user-namespace'
			then
				# on OS X force tmux's default command to spawn a shell in the user's namespace
				tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
				tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
			else
				tmux new-session && echo "tmux created new session"
			fi
		fi
	fi
}

if is_tmux_running
	then startUp
	else tmux_automatically_attach_session
fi
