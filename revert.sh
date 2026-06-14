#!/bin/bash
set -euo pipefail

LINK_TARGETS=(
    ".config"
    ".gitconfig"
    ".git-templates"
    ".ideavimrc"
    ".oh-my-zsh"
    ".tmux.conf"
    ".vimrc"
    ".zprofile"
    ".zshenv"
    ".zshrc"
    ".ssh/config"
)

get_available_timestamps() {
    for target in "${LINK_TARGETS[@]}"; do
        local dest="$HOME/$target"
        if ls -d "${dest}.backup."* &>/dev/null; then
            for f in "${dest}.backup."*; do
                local ts="${f##*.backup.}"
                # Ensure it is a 14-digit timestamp
                if [[ "$ts" =~ ^[0-9]{14}$ ]]; then
                    echo "$ts"
                fi
            done
        fi
    done | sort -u
}

# If no argument is provided, show usage and list available timestamps
if [ $# -lt 1 ]; then
    echo "Usage: $0 <backup-timestamp> | --recent"
    echo
    echo "Available backup timestamps:"
    
    timestamps=$(get_available_timestamps)
    if [ -z "$timestamps" ]; then
        echo "  (No backups found)"
    else
        while read -r ts; do
            formatted_date="${ts:0:4}-${ts:4:2}-${ts:6:2} ${ts:8:2}:${ts:10:2}:${ts:12:2}"
            echo "  - $ts ($formatted_date)"
        done <<< "$timestamps"
    fi
    exit 1
fi

ARG="$1"

if [ "$ARG" = "--recent" ]; then
    TIMESTAMP=$(get_available_timestamps | tail -n 1)
    if [ -z "$TIMESTAMP" ]; then
        echo "err: no backups found to revert"
        exit 1
    fi
    echo "Using most recent backup timestamp: $TIMESTAMP"
else
    TIMESTAMP="$ARG"
    if [[ ! "$TIMESTAMP" =~ ^[0-9]{14}$ ]]; then
        echo "err: argument must be a 14-digit timestamp or '--recent'"
        exit 1
    fi
fi

# Check if any backups actually exist for this timestamp
backups_found=0
for target in "${LINK_TARGETS[@]}"; do
    dest="$HOME/$target"
    backup="${dest}.backup.${TIMESTAMP}"
    if [ -e "$backup" ]; then
        backups_found=$((backups_found + 1))
    fi
done

if [ "$backups_found" -eq 0 ]; then
    echo "err: no backups found for timestamp $TIMESTAMP"
    exit 1
fi

echo "Reverting dotfiles symlinks to backup from $TIMESTAMP..."

for target in "${LINK_TARGETS[@]}"; do
    dest="$HOME/$target"
    backup="${dest}.backup.${TIMESTAMP}"

    if [ -e "$backup" ]; then
        if [ -L "$dest" ]; then
            echo "Removing symlink $dest"
            rm "$dest"
            mv "$backup" "$dest"
            echo "  -> Restored backup: $dest"
        elif [ -e "$dest" ]; then
            echo "Skipping $dest (it is a regular file/directory, not a symlink)"
            echo "  -> Backup is preserved at $backup"
        else
            # Path doesn't exist, just restore backup
            mv "$backup" "$dest"
            echo "Restored backup to empty path: $dest"
        fi
    fi
done

echo "Revert complete!"
