set -g fish_greeting
brew shellenv | source
source $(brew --prefix asdf)/libexec/asdf.fish
starship init fish | source

# fish_add_path -g /opt/homebrew/opt/curl/bin
# fish_add_path -g /Applications/Postgres.app/Contents/Versions/latest/bin

set -g -x EDITOR "nvim"
set -g -x ERL_AFLAGS "-kernel shell_history enabled"
set -g -x FZF_DEFAULT_COMMAND 'ag -g ""'
set -g -x VISUAL "nvim"


alias reload=". ~/.config/fish/config.fish"

# file manipulation
abbr -a v lvim
abbr -a vim lvim

# git
abbr -a g git
abbr -a gd git diff
abbr -a gs git status --short
abbr -a add git add
abbr -a addu git add -u
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
abbr -a branch git create-branch
abbr -a feature git feature
abbr -a pullom git pull origin master

function origin
  git fetch origin $argv[1]
  git checkout $argv[1]
end

function downloadpage
  wget \
      --recursive \
      --level=5 \
      --convert-links \
      --page-requisites \
      --wait=1 \
      --random-wait \
      --timestamping \
      --no-parent \
      $argv
end

# k8s
abbr -a k kubectl
abbr -a kx kubectx
abbr -a ke kubectl exec
abbr -a gp kubectl get pods

# elixir
abbr -a mx mix
abbr -a mxi iex -S mix
abbr -a mxs mix phx.server
abbr -a mxt mix test
abbr -a mxc mix compile
abbr -a mxem mix ecto.migrate
abbr -a mxd mix deps.get
abbr -a mxl mix lint

fzf_key_bindings

# set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@3/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@3/include"
# set -gx KERL_CONFIGURE_OPTIONS "--disable-debug --disable-silent-rules --without-javac"

# fish_add_path /opt/homebrew/opt/openssl@3/bin
# fish_add_path /Users/ruigil/.local/bin

direnv hook fish | source
