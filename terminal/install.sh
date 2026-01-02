#!/bin/bash
# Install GNOME Terminal color scheme
# This script creates a new profile with the color configuration

if [ ! -f "gnome-terminal.dconf" ]; then
    echo "Error: gnome-terminal.dconf not found"
    exit 1
fi

# Generate a new UUID for the profile
NEW_UUID=$(uuidgen)

echo "Creating new GNOME Terminal profile with UUID: $NEW_UUID"
echo "Loading color configuration..."

# Extract settings from dconf file and create new profile entry with new UUID
# Replace any UUID in the profile path (format: [legacy/profiles:/:UUID]) with the new one
sed "s|\[legacy/profiles:/:[^]]*\]|[legacy/profiles:/:$NEW_UUID]|" gnome-terminal.dconf | dconf load /org/gnome/terminal/

# Add the new profile to the profiles list (if not already present)
CURRENT_LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)
if [[ "$CURRENT_LIST" != *"$NEW_UUID"* ]]; then
    if [ -z "$CURRENT_LIST" ] || [ "$CURRENT_LIST" = "@as []" ]; then
        gsettings set org.gnome.Terminal.ProfilesList list "['$NEW_UUID']"
    else
        # Append the new UUID to the existing list
        NEW_LIST=$(echo "$CURRENT_LIST" | sed "s/\]$/, '$NEW_UUID']/")
        gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"
    fi
fi

# Set the new profile as default
gsettings set org.gnome.Terminal.ProfilesList default "$NEW_UUID"

echo "Terminal colors installed successfully!"
echo "Profile 'sbn' created with UUID: $NEW_UUID"
echo "You may need to restart your terminal for changes to take effect."
