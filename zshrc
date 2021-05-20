# Path to your oh-my-zsh installation.
  export ZSH="/home/r2r0m0c0/.oh-my-zsh"

# Set name of the theme to load
  ZSH_THEME="ys"

#?
  # Uncomment the following line to use case-sensitive completion.
  # CASE_SENSITIVE="true"

  # Uncomment the following line to use hyphen-insensitive completion.
  # Case-sensitive completion must be off. _ and - will be interchangeable.
  # HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
  # DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
  ENABLE_CORRECTION="true"
# WAITING DOTS
  # Uncomment the following line to display red dots whilst waiting for completion.
  # Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
  # See https://github.com/ohmyzsh/ohmyzsh/issues/5765
  COMPLETION_WAITING_DOTS="true"
#?
  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

#plugins
  plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


#alias
  alias ll='ls -l'
  alias la='ls -al'
  alias more='less'

  alias Update='~/.files/update.sh'
  alias Bat='batcat'
