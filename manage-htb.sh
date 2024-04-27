#!/bin/bash
# This script will automatically add the HTB function to your .zshrc file
# It also allows you to interactively add files to your ~/.ovpn/ directory
# You should not need to run --force unless you download a new version
# from this repository. In the case, you may want to use this flag. 
# It will not impact your ~/zshrc` file negatively, but a backup file is created`

# Define the directory where the OpenVPN configurations will be stored
OVPN_DIR="$HOME/.ovpn"
ZSH_FUNCTION_FILE="zsh-function"

# Function to update the .zshrc with the latest HTB function definition
update_zshrc() {
    if [ "$1" == "--force" ]; then
        # Overwrite the existing htb function in .zshrc
        sed -i '' '/function htb()/,/^}/d' "$HOME/.zshrc"
        echo "htb function in ~/.zshrc has been overwritten"
    else
        # Check if .zshrc already contains the htb function
        if grep -q "function htb()" "$HOME/.zshrc"; then
            echo "htb function already exists in ~/.zshrc. Use --force to overwrite."
            exit 1
        fi
    fi

    # Append the function from the zsh-function file to .zshrc
    cat "$ZSH_FUNCTION_FILE" >> "$HOME/.zshrc"
    echo "Added htb function to ~/.zshrc"
}

# Interactive part to configure a new .ovpn file
echo "Enter the type of ovpn file (lab, academy, ctf):"
read TYPE

echo "Enter a name for this configuration:"
read NAME

echo "Enter the full path to your current ovpn file:"
read OVPN_PATH

# Manually expand tilde to user's home directory
OVPN_PATH="${OVPN_PATH/#\~/$HOME}"

# Construct the new path and move the file
NEW_OVPN_PATH="$OVPN_DIR/${TYPE}_${NAME}.ovpn"

if [ -f "$OVPN_PATH" ]; then
    mv "$OVPN_PATH" "$NEW_OVPN_PATH"
    echo "Moved and renamed $OVPN_PATH to $NEW_OVPN_PATH"
else
    echo "File does not exist: $OVPN_PATH"
    exit 1
fi

# Check if the --force flag is provided
if [ "$1" == "--force" ]; then
    cp ~/.zshrc "~/.zshrc_$(date +'%m-%d-%Y@%H-%M')"
    update_zshrc --force
else
    update_zshrc
fi

echo "Configuration for $TYPE named $NAME has been set up."
