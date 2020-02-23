# Aliases ===========================================================================

# APPLICATION ALIASES

alias vim="nvim"

# FILE SYSTEM SHORTCUTS ===============

alias gh="cd ~"

# TERMINAL MANAGEMENT

alias cls="clear"

# GIT ALIASES ========================================================

# Git Status for all sub-folders in current folder
alias gsa="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status && echo)' \;"

alias ga="git add ."
alias gc="git commit -m"
alias gp="git push && git status"
alias rr="ranger"
alias cat="bat"


# PYTHON ==================================

alias pyserv="python -m http.server 8000"
