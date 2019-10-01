# status bar position
set -g status-position top

# disable status bar redrawing at interval
set -g status-interval 0

set -g status-style bg="#151515",fg="#c3c3c3"

set -g status-left-style bg="#009ddc",fg="#ffffff"
set -g status-left " #{session_name} "

set -g status-right-style bg="#8abeb7",fg="#000000"
set -g status-right " #{window_index}.#{pane_index} "

setw -g window-status-format " #{window_index}:#{window_name}#{window_flags} "
setw -g window-status-current-format " #{window_index}:#{window_name}#{window_flags} "

setw -g window-status-current-style bg="#ee2e24",fg="#ffffff"

setw -g window-status-activity-style bg="#ee2e24",fg="#151515"

setw -g pane-border-style fg="#151515"
setw -g pane-active-border-style fg="#151515"

set -g message-style bg="#ffd204",fg="#151515"

setw -g mode-style fg="#ffffff",bg="#8f9d6a"
