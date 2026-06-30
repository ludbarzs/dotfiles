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
	hl.exec_cmd([[sh -c "
        eww daemon; 
        sleep 0.5; 
        eww open bar; 
        eww update volume-live=\$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", \$2 * 100}'); 
        eww update brightness-live=\$(brightnessctl -m | awk -F, '{print substr(\$4, 1, length(\$4)-1)}');
    "]])

	hl.exec_cmd("[workspace 1 silent] firefox")
	hl.exec_cmd("[workspace 2 silent] kitty")
	hl.exec_cmd("[workspace 3 silent] kitty")
	hl.exec_cmd("[workspace 9 silent] elecwhat")
	hl.exec_cmd("[workspace 10 silent] kitty -e ncspot")
end)
