#!/bin/sh
exec <"$0" || exit; read v; read v; exec /usr/bin/osascript - "$@"; exit
# The line above allows the rest of the file to be written in plain AppleScript.
 
tell application "Google Chrome"
  activate
  tell application "System Events"
    tell process "Google Chrome"
      keystroke "r" using {command down, shift down}
      keystroke "j" using {command down}
    end tell
  end tell
end tell

delay 2
 
tell application "Terminal" to activate
delay 2
