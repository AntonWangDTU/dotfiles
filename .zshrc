# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PATH=/usr/lib/rstudio:$PATH


bindkey '^L' forward-char



bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history


export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'

alias s='sgpt'
alias vi='nvim'
alias py='python3'
alias wifi='nmtui'
alias clean='latexmk -c'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias wangsync='rclone_sync.sh'
alias Rsession='tmux attach-session -t Rsession'

function rgp(){
    # Function to grep PDFs using rga and fzf, and open the selected PDF
    # with the selected match
    rgall='(?P<file>.*):(?P<line>.*):Page\s(?P<page>\d+):(?P<match>.*)'
    rgfile='(?P<line>.*):Page\s(?P<page>\d+):(?P<match>.*)'

    if [[ -n $1 ]]; then
        # Search specified PDF
        result=$(rga "" --line-number --no-heading $1 |
                fzf | 
                rg $rgfile \
                --only-matching \
                -r '$file $page $match')
        filename=$1
        page=$(echo $result | awk '{print $1}')
        match=$(echo $result | awk '{for (i=2; i<=NF; i++) printf $i " "; print ""}')
    else
        # Search all PDFs in the current directory
        result=$(rga "" --line-number --no-heading -g '*.pdf' |
                fzf | 
                rg $rgall \
                --only-matching \
                -r '$file $page $match')
        filename=$(echo $result | awk '{print $1}')
        page=$(echo $result | awk '{print $2}')
        match=$(echo $result | awk '{for (i=3; i<=NF; i++) printf $i " "; print ""}')
    fi

    if [[ -z $filename ]]; then
        echo "No file selected"
        return
    fi

    zoom=2.5
    echo -e "Opening filename $filename with match:\n\"$match\"\n"
    zathura "$filename" --page "$page" --zoom $zoom > /dev/null 2>&1
    print -s sioyek "$filename" --page "$page" --zoom $zoom
}


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=(git tmux zsh-autosuggestions)


ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh

# source ~/miniconda3/etc/profile.d/conda.sh  # commented out by conda initialize

# User configuration

bindkey '^L' forward-char



bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
#
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Created by `pipx` on 2025-01-05 13:30:56
export PATH="$PATH:/home/aws/.local/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aws/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aws/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aws/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aws/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

