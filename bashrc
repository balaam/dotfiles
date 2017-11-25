# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:/Library/TeX/Distributions/.
export PATH=/Applications/CMake.app/Contents/bin:$PATH


export LD_LIBRARY_PATH=/opt/local/lib/:$LD_LIBRARY_PATH

export LC_CTYPE="en_GB.UTF-8"

function link_sublime() {
    mkdir -p ~/bin
    ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
    #ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
}

function link_dropbox() {
    mkdir -p ~/code
    ln -s ~/Dropbox/rpg_blog/ ~/code/rpg_blog

    mkdir -p ~/lang
    ln -s ~/Dropbox/lang ~/code/lang
}

function refresh() {
    source ~/.bash_profile
    echo "bash settings refreshed."
}

function new_post() {
    echo $1
}

function setup_git {
    git config --global user.name "Dan Schuller"
    git config --global user.email dan@godpatterns.com
    git config --global alias.co checkout
}

# Opens the most recently edited blog post in sublime
function last_post() {
    year=`date +'%Y'`
    path=~/code/project_how_to_rpg/rpg_blog/content/${year}
    last_file=$(ls -tr ${path} | tail -1)
    last_file_full_path="${path}/${last_file}"
    subl $last_file_full_path
}

alias cd..='cd ..'
alias ..='cd ..'

alias rpg='cd ~/code/project_how_to_rpg'

alias showblog='open ./output/index.html'

alias dsl='cd ~/code/dancing_squid/lib'
alias dss='cd ~/code/dancing_squid/dss'
alias ds='cd ~/code/dancing_squid/'

alias book='cd ~/Dropbox/adventure\!/rpg_book/'
alias code='cd ~/code'
alias lang='cd ~/lang'
alias cv='cd ~/Documents/me/job_2016'
alias restart_stage='ssh REMOTE_STAGE sudo service nginx restart'
alias restart_prod='ssh REMOTE_PRODUCTION sudo service nginx restart'

function blog {
    year=`date +'%Y'`
    cd ~/code/project_how_to_rpg/rpg_blog/content/${year}
}

export EDITOR='subl_wait'
export GIT_EDITOR='subl -w'

# Notes
#
# = modifying commands =
# $ ehco foo bar baz
# bash: ehco: command not found
# $ ^ehco^echo
# foo bar baz
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Git branch in prompt.

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}

export PS1="\h:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
