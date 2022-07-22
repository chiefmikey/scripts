# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

# Load nvm on zsh exec
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
# Set nvm directory
export NVM_DIR="$HOME/.nvm"
# Load nvm on alias exec
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"
# Load nvm bash_completion
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Vscode version
alias code="code-insiders"

# Update scripts
alias auto-update-homebrew="brew autoupdate start 21600 --upgrade --cleanup --greedy --immediate"
alias update-homebrew="~/dropbox/dev/apps/extra/scripts/update-homebrew.sh"
alias update-npm-global="~/dropbox/dev/apps/extra/scripts/update-npm-global.sh"
alias update="update-homebrew; update-npm-global"

# Sync scripts
alias sync-apps="~/dropbox/dev/apps/extra/scripts/sync-apps.sh"

# Misc
path+=/usr/local/sbin
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export GPG_TTY=$(tty)

# zsh syntax highlighting (must be at end of zshrc)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
