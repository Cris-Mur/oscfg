#
# ~/.bashrc
#[ @Cris-Mur ]
#
# ~/.bashrc: executed by bash(1) for non-login shells.

if [ -f ~/.bash_cfg_profile ]; then
	. ~/.bash_cfg_profile
fi

if [ -f ~/.bash_cfg_history ]; then
	. ~/.bash_cfg_history
fi

if [ -f ~/.bash_cfg_prompt ]; then
	. ~/.bash_cfg_prompt
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Bash Completion settings
if [ -f ~/.bash_cfg_completion ]; then
	. ~/.bash_cfg_completion
fi

neofetch;
# load enviroment variables dir
if [ -d ~/env/ ]; then
	env_counter=0;
	for env_file in ~/env/*
	do
    	. $env_file
		let env_counter++;
	done
	echo "$env_counter# Enviroment files are loaded."
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/crismur/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
