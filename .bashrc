
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
source ~/.custom_commands.sh

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

