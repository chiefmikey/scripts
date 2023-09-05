#!/bin/sh

echo "+ dock sort"
cd "${HOME}" || exit

defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock recent-apps

dock_item() {
  printf '
    <dict>
    <key>tile-data</key>
    <dict>
    <key>file-data</key>
    <dict>
    <key>_CFURLString</key>
    <string>%s</string>
    <key>_CFURLStringType</key>
    <integer>0</integer>
    </dict>
    </dict>
    </dict>
  ', "$1"
}

if [ "$(whoami)" = "mwolfe" ]; then
  defaults write com.apple.dock persistent-apps -array \
  "$(dock_item /Applications/Brave\ Browser.app)" \
  "$(dock_item /Applications/Google\ Chrome.app)" \
  "$(dock_item /Applications/iTerm.app)" \
  "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
  "$(dock_item /Applications/Docker.app)" \
  "$(dock_item /Applications/Postman.app)" \
  "$(dock_item /Applications/Lens.app)" \
  "$(dock_item /Applications/Slack.app)" \
  "$(dock_item /Applications/Microsoft\ Outlook.app)" \
  "$(dock_item /Applications/Microsoft\ Teams.app)" \
  "$(dock_item /Applications/Microsoft\ Teams\ \(work\ preview).app)" \
  "$(dock_item /Applications/Notion.app)"
else
  defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /Applications/Brave\ Browser.app)" \
    "$(dock_item /Applications/Google\ Chrome.app)" \
    "$(dock_item /System/Applications/Messages.app)" \
    "$(dock_item /Applications/Discord.app)" \
    "$(dock_item /Applications/Spotify.app)" \
    "$(dock_item /System/Applications/Music.app)" \
    "$(dock_item /Applications/Apogee\ Control.app)" \
    "$(dock_item /Applications/Logic\ Pro\ X.app)" \
    "$(dock_item /Applications/Reason\ Suite\ 11.app)" \
    "$(dock_item /Applications/Final\ Cut\ Pro.app)" \
    "$(dock_item /Applications/Motion.app)" \
    "$(dock_item /Applications/Affinity\ Photo\ 2.app)" \
    "$(dock_item /Applications/Affinity\ Designer\ 2.app)" \
    "$(dock_item /System/Applications/Photos.app)" \
    "$(dock_item /Applications/iTerm.app)" \
    "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(dock_item /Applications/Visual\ Studio\ Code\ -\ Insiders.app)" \
    "$(dock_item /Applications/Docker.app)" \
    "$(dock_item /Applications/Postman.app)" \
    "$(dock_item /Applications/Parallels\ Desktop.app)" \
    "$(dock_item /Applications/Notion.app)"
fi

killall Dock
