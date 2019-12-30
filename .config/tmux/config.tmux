# Inspired by https://github.com/nicknisi/dotfiles/
set -g status on
set -g status-keys vi

set -g history-limit 1000000

unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

set -g default-terminal "screen-256color"
# set -g status-utf8 on

set-option -g pane-active-border-fg blue

# Rather than constraining window size to the maximum size of any client
# connected to the *session*, constrain window size to the maximum size of any
# client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

# make delay shorter
set -sg escape-time 0
set -sg repeat-time 600

# Quick pane cycling
# unbind ^A
# bind ^A select-pane -t :.+

# tile all windows
unbind =
bind = select-layout tiled

# make window/pane index start with 1
set -g base-index 1
setw -g pane-base-index 1

set-option -g set-titles on
# set-option -g set-titles-string "#T - #W"
set -g set-titles-string '#S:#I.#P #W'

# Autorename sanely.
setw -g automatic-rename on

# Better name management
bind c new-window
bind , command-prompt "rename-window '%%'"

# More straight forward key bindings for splitting
unbind %
bind | split-window -h
bind h split-window -h
unbind '"'
bind - split-window -v
bind v split-window -v

######################
##### Key Bindings ####
#######################

# smart pane switching with awareness of vim splits
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

# reload config file
bind r source-file ~/.config/tmux/config.tmux \; display "Config Reloaded!"

# # quickly open a new window
bind N new-window

# # split window and fix path for tmux 1.9
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# # synchronize all panes in a window
bind y setw synchronize-panes

# # pane movement shortcuts
#bind h select-pane -L
#bind j select-pane -D
#bind k select-pane -U
#bind l select-pane -R

bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# # Resize pane shortcuts
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# enable mouse support for switching panes/windows
set -g mouse on

bind-key -T root PPage if-shell -F "#{alternate_on}" "send-keys PPage" "copy-mode -e; send-keys PPage"
bind-key -T copy-mode-vi PPage send-keys -X page-up
bind-key -T copy-mode-vi NPage send-keys -X page-down

bind -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "select-pane -t =; send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
bind -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "select-pane -t =; send-keys -M" "select-pane -t =; send-keys -M"
bind-key -T copy-mode-vi WheelUpPane send-keys -X halfpage-up
bind-key -T copy-mode-vi WheelDownPane send-keys -X halfpage-down

# set vi mode for copy mode
setw -g mode-keys vi

# more settings to make copy-mode more vim-like
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

# Remap the copy & paste keys to work as in vim
unbind [
bind Escape copy-mode
unbind p
bind p paste-buffer

#############
### Theme ###
#############

# source-file ~/.config/tmux/.solarized.light.theme
# source-file ~/.config/tmux/.solarized.dark.theme

# From: http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
# panes
set -g pane-border-fg black
set -g pane-active-border-fg brightred

## Status bar design
# status line
set -g status-justify left
set -g status-bg default
set -g status-fg colour12
set -g status-interval 2

# messaging
set -g message-fg black
set -g message-bg yellow
set -g message-command-fg blue
set -g message-command-bg black

#window mode
setw -g mode-bg colour6
setw -g mode-fg colour0

# window status
setw -g window-status-format " #F#I:#W#F "
setw -g window-status-current-format " #F#I:#W#F "
setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
setw -g window-status-current-bg colour0
setw -g window-status-current-fg colour11
setw -g window-status-current-attr dim
setw -g window-status-bg green
setw -g window-status-fg black
setw -g window-status-attr reverse

# Info on left (I don't have a session display for now)
set -g status-left ''

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

set -g default-terminal "screen-256color"

# The modes {
setw -g clock-mode-colour colour135
setw -g mode-attr bold
setw -g mode-fg colour196
setw -g mode-bg colour238

# }
# The panes {

set -g pane-border-bg colour235
set -g pane-border-fg colour238
set -g pane-active-border-bg colour236
set -g pane-active-border-fg colour51

# }
# The statusbar {

set -g status-position bottom
set -g status-bg colour234
set -g status-fg colour137
set -g status-attr dim
set -g status-left ''
# set -g status-right '#(sh ~/.config/tmux/next-appointment.sh) #[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-fg colour81
setw -g window-status-current-bg colour238
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '

setw -g window-status-fg colour138
setw -g window-status-bg colour235
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# }
# The messages {

set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour166

# }

# set -g window-style 'fg=colour247,bg=colour236'
# set -g window-active-style 'fg=colour250,bg=black'
