# bass source ~/.exports
# bass source ~/.aliases

alias reload=". ~/.config/fish/config.fish"
alias venv "source venv/bin/activate.fish"
alias vim "nvim"
alias ls "exa"
alias poetry="python3 $HOME/.poetry/bin/poetry"

abbr -a note $EDITOR ~/notes/(date +%Y-%m-%d).txt

abbr -a tmux tmux -f ~/.config/tmux/config.tmux

abbr -a g git
abbr -a gd git diff
abbr -a gs git status --short
abbr -a add git add
abbr -a gst git status
abbr -a gds git diff --staged
abbr -a grm git ls-files --deleted -z | xargs -0 git rm
abbr -a fix git feature -a fix
abbr -a push git push
abbr -a pull git pull
abbr -a clone git clone
abbr -a chore git chore
abbr -a check git checkout
abbr -a amend git commit --amend
abbr -a rebase rebase
abbr -a commit git commit -m \"
abbr -a branch git branch
abbr -a feature git feature
abbr -a pullom git pull origin master

abbr -a tree tree -I "'node_modules|bin|lib|include'"

abbr -a v nvim

abbr -a p python
abbr -a dj python manage.py
abbr -a ipy ipython

abbr -a run pipenv run
abbr -a rundj pipenv run python manage.py
abbr -a runrun pipenv run python manage.py runserver
abbr -a runshell pipenv run python manage.py shell

# k8s
abbr -a k kubectl
abbr -a kx kubectx
abbr -a ke kubectl exec
abbr -a gp kubectl get pods

abbr -a getpods kubectl get pods
abbr -a deletepod kubectl delete pod
abbr -a describepod kubectl describe pod

function killf
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
    kill -9 (cat $TMPDIR/fzf.result)
  end
end


function clone --description "clone something, cd into it. install it."
    git clone --depth=1 $argv[1]
    cd (basename $argv[1] | sed 's/.git$//')
    yarn install
end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end


# function ls --wraps cd -d "Ls"
#   exa -s name --group-directories-first $argv
#   # builtin ls $argv
# end


function cd --wraps cd -d "Cds into a directory and executes ls"
  builtin cd $argv
  ls -a
end
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-getopt/bin" $fish_user_paths


function kshell
  for option in $argv
    switch "$option"
      case -p --production
        kubectx aws-prd
      case -s --staging
        kubectx aws-stg
    end
  end
  set name $argv[1]
  set podname (kubectl get pods | grep "$name-[^-]\+-[^-]\+-[^-]\+ " | head -n 1 | cut -d ' ' -f 1)
  kubectl exec -it $podname -- python manage.py shell_plus
end

function origin
  git fetch origin $argv[1]
  git checkout $argv[1]
end
