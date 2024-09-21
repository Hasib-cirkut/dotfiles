# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

if command -v fzf &> /dev/null; then
    current_version=$(fzf --version | grep -oE '[0-9]+(\.[0-9]+)+')
    min_version="0.48.0"
    if [[ "$(printf '%s\n' "$min_version" "$current_version" | sort -V | head -n1)" == "$min_version" && "$current_version" != "$min_version" ]]; then
      source <(fzf --zsh)
      alias inv='nvim $(fd --type f --hidden --exclude .git --exclude "node_modules"| fzf -m --preview="bat --color=always {}")'

    else
      source /usr/share/doc/fzf/examples/completion.zsh
      source /usr/share/doc/fzf/examples/key-bindings.zsh
    fi
else
    echo "fzf is not installed. Please visit this link to install. https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration"
fi


plugins=(git fast-syntax-highlighting fzf-tab)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v pyenv &> /dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH" && eval "$(pyenv init --path)"
fi

export PATH="$HOME/.local/bin:$PATH"

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
