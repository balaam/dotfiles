# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:~/bin

export LC_CTYPE="en_GB.UTF-8"

function link_sublime() {
    mkdir -p ~/bin
    ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
}

function refresh() {
    source ~/.bash_profile
    echo "bash settings refreshed."
}


function book() {
    cd ~/Dropbox/adventure\!/rpg_book/
}

function code() {
    cd ~/code
}

function ds() {
    cd ~/code/dancing_squid/
}

function dss() {
    cd ~/code/dancing_squid/src
}

function dsl() {
    cd ~/code/dancing_squid/lib
}

function new_post() {
    echo $1
}

# Opens the most recently edited blog post in sublime
function last_post() {
    year=`date +'%Y'`
    path=~/code/rpg_blog/content/${year}
    last_file=$(ls -tr ${path} | tail -1)
    last_file_full_path="${path}/${last_file}"
    subl $last_file_full_path
}

alias cd..='cd ..'

# Notes
#
# = modifying commands =
# $ ehco foo bar baz
# bash: ehco: command not found
# $ ^ehco^echo
# foo bar baz