#!/bin/bash
# Enables middle click to scroll (like Windows).
set -e

: ${SCRIPT_PATH:=~/.local/bin/middle_click_to_scroll.sh}
: ${DESKTOP_PATH:=~/.config/autostart/middle_click_to_scroll.desktop}

# Create dirs if they don't exist.
echo "$SCRIPT_PATH" "$DESKTOP_PATH" | xargs dirname | xargs mkdir -p

# Create a script that can be run on-demand.
# When run, it enables middle-click to scroll.
cat > "$SCRIPT_PATH" << EOF
#!/bin/bash

# Get device IDs of all devices containing "pointer"
pointer_ids=(\$(xinput list | grep pointer | perl -p -e 's@.*?id=(\d+).*@\1@'))

for pointer_id in "\${pointer_ids[@]}"; do
  # If the pointer supports scroll method, set middle click to scroll
  if xinput list-props "\$pointer_id" | grep 'Scroll Method Enabled' &>/dev/null; then
    xinput set-prop "\$pointer_id" 'libinput Scroll Method Enabled' 0 0 1
  fi
done
EOF
chmod +x "$SCRIPT_PATH"

# Create a desktop entry so it runs on startup.
cat > "$DESKTOP_PATH" << EOF
[Desktop Entry]
Type=Application
Name=Middle click to scroll
Exec="$SCRIPT_PATH"
X-GNOME-Autostart-Phase=Initialization
Terminal=false
NoDisplay=true
EOF

"$SCRIPT_PATH"
