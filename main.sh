#!/bin/bash

# Base configuration: Define paths for scripts directory and alias configuration file
SCRIPTS_DIR="$HOME/scripts"
ALIASES_FILE="$SCRIPTS_DIR/aliases.conf"

# Display usage instructions and list of available aliases
show_usage() {
    echo "Usage: $(basename $0) <alias> [arguments]"
    echo "Available aliases:"
    if [ -f "$ALIASES_FILE" ]; then
        # Remove comment lines and display alias to filename mappings
        grep -v "^#" "$ALIASES_FILE" | grep "=" | while IFS='=' read -r alias filename; do
            echo "  $alias -> $filename"
        done
    else
        echo "No aliases configured"
    fi
    exit 1
}

# Initial check 1: Verify scripts directory exists
if [ ! -d "$SCRIPTS_DIR" ]; then
    echo "Error: Scripts directory ($SCRIPTS_DIR) not found"
    exit 1
fi

# Initial check 2: Verify alias configuration file exists
if [ ! -f "$ALIASES_FILE" ]; then
    echo "Error: Aliases configuration file not found"
    echo "Please create: $ALIASES_FILE"
    exit 1
fi

# Argument validation: Check if alias name is provided
if [ $# -eq 0 ]; then
    echo "Error: Alias name is required"
    show_usage
fi

# Get the provided alias name from first argument
alias_name="$1"

# Extract script name from alias configuration file:
# - Remove comment lines
# - Find line matching the alias
# - Extract filename after '=' delimiter
script_name=$(grep -v "^#" "$ALIASES_FILE" | grep "^$alias_name=" | cut -d'=' -f2)

# Error handling for non-existent alias
if [ -z "$script_name" ]; then
    echo "Error: Alias '$alias_name' not found in configuration"
    show_usage
fi

# Construct full path to the target script
script_path="$SCRIPTS_DIR/$script_name"

# Verify target script exists
if [ ! -f "$script_path" ]; then
    echo "Error: Script '$script_name' not found in $SCRIPTS_DIR"
    echo "Available scripts:"
    ls -1 "$SCRIPTS_DIR"
    exit 1
fi

# Check and grant execute permission if needed
if [ ! -x "$script_path" ]; then
    chmod +x "$script_path"
fi

# Remove alias argument and execute script with remaining arguments
shift
"$script_path" "$@"