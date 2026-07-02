-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("wallust run Pictures/fire.jpg")
	hl.exec_cmd([[sh -c "qs --path ~/.config/quickshell/capllet/shell.qml"]])

	hl.exec_cmd("[workspace 1 silent] kitty -e zsh -c 'nvim ~/source-code/dotfiles/; exec zsh'")
	hl.exec_cmd("[workspace 2 silent] firefox")
	hl.exec_cmd("[workspace 3 silent] kitty")
	hl.exec_cmd("[workspace 4 silent] kitty")
	hl.exec_cmd("[workspace 10 silent] elecwhat")
	hl.exec_cmd("[workspace 11 silent] kitty -e ncspot")
end)
