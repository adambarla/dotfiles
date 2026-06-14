# Homebrew initialization (macOS Apple Silicon)
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# JetBrains Toolbox scripts
if [ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]; then
    export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
fi

# Local bin directory
export PATH="$HOME/.local/bin:$PATH"

# CodeWhisperer pre block. Keep at the top of this file if used.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh"

# CodeWhisperer post block. Keep at the bottom of this file if used.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh"
