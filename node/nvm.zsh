# -------------------------------------------------------
# Lazy-load nvm via alias + helper function
# -------------------------------------------------------
# Developed via https://chatgpt.com/share/e/676df861-228c-8006-9a61-d5cd336cf522

# The helper function that does the real loading:
_lazy_nvm() {
  # Unalias nvm so subsequent calls go straight to the real nvm
  unalias nvm 2>/dev/null

  # Point to your nvm installation
  export NVM_DIR="$HOME/.nvm"

  # Actually source nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

  # Now invoke the real nvm command with any given args
  nvm "$@"
}

# Create an alias so that typing "nvm" actually calls _lazy_nvm().
# This only affects the first call—after that, the real nvm is used.
alias nvm="_lazy_nvm"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc
