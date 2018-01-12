(* TODO: Figure out how to check for installed app before trying to see if it's running *)

on run
	tell application "System Events"
		start current screen saver
	end tell

	if application "Spotify" is running then
		tell application "Spotify"
			pause
		end tell
	end if

	if application "Amazon Music" is running then
		tell application "Amazon Music"
			pause
		end tell
	end if

	if application "iTunes" is running then
		tell application "iTunes"
			pause
		end tell
	end if

end run

