# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# Directories to be prepended to $PATH

declare -a dirs_to_prepend
dirs_to_prepend=(
  "$HOME/dotfiles/bin"
  "$HOME/bin"
  "$HOME/.rvm/bin"
  "$(brew --prefix ruby)/bin"
  "$(brew --prefix coreutils)/libexec/gnubin" # Add brew-installed GNU core utilities bin
  "$(brew --prefix)/share/npm/bin" # Add npm-installed package bin
  "$HOME/.composer/vendor/bin"
  "$HOME/.yarn/bin"
  "$(brew --prefix php)/bin"
  "/usr/local/opt/php@7.3/bin"
  "/usr/local/opt/openssl/bin"
  "/usr/local/opt/mysql@5.7/bin"
)

# Explicitly configured $PATH
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

for dir in ${(k)dirs_to_prepend[@]}
do
  if [ -d ${dir} ]; then
    # If these directories exist, then prepend them to existing PATH
    PATH="${dir}:$PATH"
  fi
done

unset dirs_to_prepend

export PATH

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

# Z beats cd most of the time
. ~/z/z.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=$HOME/dotfiles/zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew node npm history)

# User configuration

# Load the shell dotfiles
for file in $HOME/.{shell_exports,shell_aliases,shell_functions,shell_config}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Automatically list directory contents on `cd`.
auto-ls () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}
chpwd_functions=( auto-ls $chpwd_functions )

source $ZSH/oh-my-zsh.sh

# Source local extra (private) settings specific to machine if it exists
[ -f ~/.zsh.local ] && source ~/.zsh.local

# npm tab completion
#. <(npm completion)

# fortune: brew install fortune ponysay
# fortune

###
###
### Jeff's User Settings
###
###

# Add SSH key to ssh-agent to avoid retyping it constantly.
~/add-identity

#
# Spaceship oh-my-zsh theme
#

source "/Users/jeffrose/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# ORDER
SPACESHIP_PROMPT_ORDER=(
  time     #
  vi_mode  # these sections will be
  user     # before prompt char
  host     #
  char
  dir
  git
  #node
  #php
)

# TIME
SPACESHIP_TIME_SHOW="true"
SPACESHIP_TIME_FORMAT="%t"
SPACESHIP_TIME_12HR="true"
SPACESHIP_TIME_COLOR="yellow"

# USER
SPACESHIP_USER_PREFIX="" # remove `with` before username
SPACESHIP_USER_SUFFIX="" # remove space before host

# HOST
# Result will look like this:
#   username@:(hostname)
SPACESHIP_HOST_PREFIX="@:("
SPACESHIP_HOST_SUFFIX=") "

# DIR
SPACESHIP_DIR_PREFIX='' # disable directory prefix, cause it's not the first section
SPACESHIP_DIR_TRUNC='1' # show only last directory

# GIT
# Disable git symbol
SPACESHIP_GIT_SYMBOL="" # disable git prefix
SPACESHIP_GIT_BRANCH_PREFIX="" # disable branch prefix too
# Wrap git in `git:(...)`
SPACESHIP_GIT_PREFIX='git:('
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_SUFFIX="" # remove space after branch name
# Unwrap git status from `[...]`
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# PHP
SPACESHIP_PHP_PREFIX="php:("
SPACESHIP_PHP_SUFFIX=") "
SPACESHIP_PHP_SYMBOL=""

# NODE
SPACESHIP_NODE_PREFIX="node:("
SPACESHIP_NODE_SUFFIX=") "
SPACESHIP_NODE_SYMBOL=""

#
#
# Functions
#

# Deploy
function deploy {
   ansible-playbook deploy.yml -l $1 -e branch=$2 -v
}

# List out the branches matching the pattern.
gbgrep() {
    local BRANCHES=`git branch -l | grep -e $1`
    local LINES=`echo $BRANCHES | wc -l`

    local BOLD=$(tput bold)
    local UNBOLD=$(tput sgr0)

    echo ""
    echo ${BOLD}"  $LINES branches match the pattern \"$1\"..."${UNBOLD}
    echo ""
    git branch -l | grep -e $1
}

# Checkout the branch matching the pattern, or if there 
# are several matches, list them out. Handy for checking
# out a feature branch with only its Pivotal ID.
gcgrep() {
    local BRANCHES=`git branch -l --no-color | tr -d '*' | awk '{print $1}' | grep -e $1`
    local LINES=`echo $BRANCHES | wc -l`

    if [ "$LINES" = "1" ]; then
        git checkout $BRANCHES
    else
        echo gbgrep $LINES
    fi
}

grofff() {
    local BRANCH=`git branch --no-color | grep \* | cut -d ' ' -f2`
    git fetch --all
    git reset origin/$BRANCH --hard
}

#
# Command aliases
#

alias art="php artisan"
alias artt="php artisan tinker"
alias conflicts="git diff --name-only --diff-filter=U"
alias composer="php /usr/local/bin/composer.phar"
alias fresh="php artisan cache:clear & php artisan migrate:fresh"
alias ga="git add"
alias gaa="git add -A"
alias gbl="git branch --list"
alias gc="git checkout"
alias gcb="git checkout -b --track"
alias gcc="git checkout @{-1}"
alias gcv="git commit -v"
alias gcva="git commit -v --amend"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdlb='git branch -vv --no-color | grep "origin/.*: gone].*" | awk "{print \$1}" | xargs git branch -D' # Delete local branches that have been deleted on remote
alias gfa="git fetch --all"
alias gg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gil="gh issue list"
alias gis="gh issue status"
alias giv="gh issue view"
alias ghc="gh pr checkout"
alias ghl="gh pr list"
alias ghs="gh pr status"
alias ghv="gh pr view"
alias gl="git log"
alias gpr="git pull --rebase"
alias gpu="git push"
alias gpufff="git push -f"
alias gr="git rebase"
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias grid="git hf update ; git rebase -i develop"
alias grs="git rebase --skip"
alias gs="git status"
alias gsu="git stash -u"
alias gsp="git stash pop"
alias larafzf='find . \
    -type f \
    -not -path "*/.git/*" \
    -not -path "*/node_modules/*" \
    -not -path "*/vendor/*" \
    -not -path "*/storage/framework/*"'

alias ll="~/projects/lootleague"
alias llog="tail -n100 ./storage/logs/laravel.log"
alias riv="~/projects/rivalry"
alias test="phpunit --printer=Codedungeon\\\\PHPUnitPrettyResultPrinter\\\\Printer"
alias v="vim --servername VIM --remote-tab"
alias vc="v con"
alias vf="v fzf"
#alias vim=vimgleton
alias vedit="vim ~/.vimrc"
alias wellshit="php artisan migrate:fresh && php artisan db:seed --class GameSeeder && php artisan betradar:categories && php artisan betradar:tournaments && php artisan betradar:matches"
alias zedit="vim ~/.zshrc"
alias zfresh="source ~/.zshrc"

# Generate ctags for shauncplus/phpcomplete.vim
alias phpctags="ctags -R --fields=+aimlS --languages=php"

# Build and watch rivalry frontend
alias nuxtlocal='NODE_ENV=local NOW_CONFIG=../now.local.json nuxt dev'

