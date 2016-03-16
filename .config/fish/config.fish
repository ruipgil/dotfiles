set -g -x PATH /usr/local/bin $PATH
set -g -x PATH ~/bin $PATH

source ~/.config/fish/aliases.fish

set -x GOPATH = ~/golang
set -x EDITOR nvim
set -x VISUAL nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBXOPT -X19

# Completions
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

make_completion g 'git'
make_completion v 'nvim'


# rbenv
if test -d $RBENV_ROOT
  set PATH $RBENV_ROOT/bin $PATH
  set PATH $RBENV_ROOT/shims $PATH
  rbenv rehash >/dev/null ^&1
end
# THEME PURE #
set fish_function_path /Users/ruipgil/.config/fish/functions/theme-pure $fish_function_path
