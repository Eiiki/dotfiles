
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
	echo "Initializing new SSH agent..."
	# spawn ssh-agent
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	start_agent;
}
else
	start_agent;
fi

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
source ~/.custom_commands.sh

alias gs="git status"
alias rmf="rm -rf"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

function gitopen {
	if [ -d .git ]; then
		remotes=$(git remote -v | awk -F'git@github.com:' '{print $2}' | cut -d" " -f1)
		if [ -z "$remotes" ];
		then
			remotes=$(git remote -v | awk -F'https://github.com/' '{print $2}' | cut -d" " -f1)
		fi

		remote_url=$(echo $remotes | cut -d" " -f1)
		url="https://github.com/"
		branch=$(git name-rev --name-only HEAD)
		url="${url}${remote_url%.*}/tree/${branch}/"
		#echo "${branch%.*}"
		/usr/bin/open -a "/Applications/Google Chrome.app" $url
	else
		echo "Not a git repo"
fi;
}
