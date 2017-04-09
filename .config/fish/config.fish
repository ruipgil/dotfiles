set -g -x PATH /usr/local/bin $PATH
set -g -x PATH ~/bin $PATH

source ~/.config/fish/aliases.fish

set -x GOPATH $HOME/golang
set -x EDITOR nvim
set -x VISUAL nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBXOPT -X19

set FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

if test -d $GOPATH
    set -g -x PATH $GOPATH/bin $PATH
end

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

function tdev
    read -l -p tdev-ask name
    switch $name
        case ''
          set name "dev"
    end
    tmux rename-window $name
    tmux split-window -v -p 20 -t $name
    tmux select-pane -t 2
    tmux split-window -h -p 40 -t $name
end

function tdev-ask
    echo "What's the name of the window? (dev)"
end


# rbenv
if test -d $RBENV_ROOT
  set PATH $RBENV_ROOT/bin $PATH
  set PATH $RBENV_ROOT/shims $PATH
  rbenv rehash >/dev/null ^&1
end
# THEME PURE #
set fish_function_path $HOME/.config/fish/functions/theme-pure $fish_function_path

