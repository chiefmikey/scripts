#!/bin/sh

echo "+ dock sort"
cd ${HOME}

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

defaults write com.apple.dock persistent-apps -array \
  "$(dock_item /Applications/Google\ Chrome.app)" \
  "$(dock_item /System/Applications/Messages.app)" \
  "$(dock_item /Applications/Spotify.app)" \
  "$(dock_item /Applications/Apogee\ Control.app)" \
  "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
  "$(dock_item /Applications/iTerm.app)" \
  "$(dock_item /Applications/Postman.app)" \
  "$(dock_item /Applications/Docker.app)" \
  "$(dock_item /Applications/IVPN.app)" \
  "$(dock_item /Applications/Parallels\ Desktop.app)" \
  "$(dock_item /Applications/Cisco/Cisco\ AnyConnect\ Secure\ Mobility\ Client.app)" \
  "$(dock_item /Applications/Slack.app)" \
  "$(dock_item /Applications/Microsoft\ Outlook.app)" \
  "$(dock_item /Applications/Microsoft\ Teams.app)" \
  "$(dock_item /Applications/Notion.app)"

killall Dock
