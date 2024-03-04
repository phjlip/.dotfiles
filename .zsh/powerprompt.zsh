#========================
#|   ZSH Prompt Fancy   |
#========================

# FIXME Refactor the variable naming, w/o linebreak etc

# setup virtualenv support
setopt PROMPT_SUBST
source ~/.zsh/helper/virtualenv.zsh

WITH_LINEBREAK=1
USER_COLOR='black'
HOST_COLOR='black'
DIR_COLOR='black'
FIRST_COLOR='green'
SEC_COLOR='blue'
THIRD_COLOR='magenta'
PARAN_COLOR='magenta'
VENV_COLOR='blue'
LB_COLOR='yellow'
GIT_COLOR='red'

PARAN_L=''
PARAN_R=''

LB_CHAR_UP="%F{$LB_COLOR}╭─%f"
# LB_CHAR_UP=''
LB_CHAR_DOWN="%F{$LB_COLOR}╰─%f"
# LB_CHAR_DOWN=''

PROMPT_SYMBOL=''

# GIT_TRANS='%K{$DIR_COLOR}%k'
GIT_TRANS="%K{$GIT_COLOR}%F{$PARAN_COLOR}$PARAN_R%f%k"
GIT_SYMBOL="%F{$USER_COLOR} %f"
NEWLINE=$'\n'

C_BEG="%F{$GIT_COLOR}"
C_END="%f"

GIT_BEG="%B%K{$GIT_COLOR}"
GIT_END="%k%b"

VIRTUALENV_PREFIX="%F{$VENV_COLOR}$PARAN_L%f%K{$VENV_COLOR}%F{black}"
VIRTUALENV_SUFFIX="%f%k%F{$VENV_COLOR}$PARAN_R%f "

# NOTE Prompt Pre Parts have to be in "" not in ''
HOST_TRANS="%K{$SEC_COLOR}%F{$FIRST_COLOR}$PARAN_R%f%k"
DIR_TRANS="%K{$THIRD_COLOR}%F{$SEC_COLOR}$PARAN_R%f%k"

PROMPT_USER="%B%F{$FIRST_COLOR}$PARAN_L%f%K{$FIRST_COLOR}%F{$USER_COLOR}%n$HOST_TRANS%K{$SEC_COLOR}%F{$HOST_COLOR} %m%f%b"
PROMPT_DIR=" $DIR_TRANS%K{$THIRD_COLOR}%B%F{$DIR_COLOR} %(3~|../%2~|%~)%f%k%b"

# Build prompt
if [ $WITH_LINEBREAK = 1 ]; then
	# PROMPT_PRE='%F{$LB_COLOR}╭─%f$(virtualenv_prompt_info)$PROMPT_USER$PROMPT_DIR%F{$THIRD_COLOR}'
	PROMPT_PRE='$LB_CHAR_UP$(virtualenv_prompt_info)$PROMPT_USER$PROMPT_DIR%F{$THIRD_COLOR}'
	# PROMPT_GIT='$C_END$GIT_TRANS$GIT_BEG$GIT_SYMBOL %s $GIT_END$C_BEG'
	PROMPT_GIT='$C_END$GIT_TRANS$GIT_BEG$GIT_SYMBOL %s $GIT_END$C_BEG'
	# PROMPT_SUF='$PARAN_R%f$NEWLINE%F{$LB_COLOR}╰─%f%B%(?.%F{green}$PROMPT_SYMBOL.%F{red}$PROMPT_SYMBOL)%f%b '

	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		PROMPT_SUF='$PARAN_R%f$NEWLINE$LB_CHAR_DOWN%B%F{yellow}$PROMPT_SYMBOL%f%b '
	else;
		PROMPT_SUF='$PARAN_R%f$NEWLINE$LB_CHAR_DOWN%B%(?.%F{green}$PROMPT_SYMBOL.%F{red}$PROMPT_SYMBOL)%f%b '
	fi
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
C_STATES="%F{black}"
C_BRANCH="%F{black}"
C_SPECIAL="%F{magenta}"
