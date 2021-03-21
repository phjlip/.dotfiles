#========================
#|   ZSH Prompt Basic   |
#========================

# setup virtualenv support
setopt PROMPT_SUBST
source ~/.zsh/helper/virtualenv.zsh

WITH_LINEBREAK=1
USER_COLOR='green'
HOST_COLOR='green'
DIR_COLOR='cyan'
PARAN_COLOR='red'
VENV_COLOR='blue'
LB_COLOR='blue'

PARAN_L='%F{$PARAN_COLOR}[%f'
PARAN_R='%F{$PARAN_COLOR}]%f'
LB_CHAR_UP='%F{$LB_COLOR}╭─%f'
LB_CHAR_DOWN='%F{$LB_COLOR}╰─%f'
PROMPT_SYMBOL='$'
GIT_SYMBOL='on'
NEWLINE=$'\n'

VIRTUALENV_PREFIX='%F{$VENV_COLOR}('
VIRTUALENV_SUFFIX=')%f '

# NOTE Prompt Pre Parts have to be in "" not in ''
PROMPT_USER="%B$PARAN_L%F{$HOST_COLOR}%n%F{blue}@%F{$HOST_COLOR}%m%f%b"
PROMPT_DIR=" %B%F{$DIR_COLOR}%(3~|../%2~|%~)%f$PARAN_R%b"

# Build prompt
if [ $WITH_LINEBREAK = 1 ]; then
	PROMPT_PRE='$LB_CHAR_UP$(virtualenv_prompt_info)$PROMPT_USER$PROMPT_DIR'
	PROMPT_GIT=' \033[32;1m$GIT_SYMBOL %s \033[0m'
	PROMPT_SUF='$NEWLINE$LB_CHAR_DOWN%B%(?.%F{green}$PROMPT_SYMBOL.%F{red}$PROMPT_SYMBOL)%f%b '
else
	PROMPT_PRE='$(virtualenv_prompt_info)$PROMPT_USER$PROMPT_DIR'
	PROMPT_GIT=' \033[32;1m$GIT_SYMBOL %s \033[0m'
	PROMPT_SUF='%B%(?.%F{green}$PROMPT_SYMBOL.%F{red}$PROMPT_SYMBOL)%f%b '
fi

# setup git support
source ~/.zsh/helper/git-prompt.sh
precmd () { __git_ps1 $PROMPT_PRE $PROMPT_SUF $PROMPT_GIT }

# git prompt options
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_STATESEPARATOR='%F{blue} %f'

# Variables
AHEAD_SYM="%F{207}↑%f"
BEHIND_SYM="%F{207}↓%f"
DIVERGED_SYM="%F{207}↓↑%f"
EQUAL_SYM=""
UNTRACKED_SYM="\?"
MODIFIED_SYM="*"
STAGED_SYM="+"
STASHED_SYM="§"

# Git Colors
C_STATES="%F{cyan}"
C_BRANCH="%F{yellow}"
C_SPECIAL="%F{blue}"
