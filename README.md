# Bashtools
Misc bash/sed/awk/etc scripts



~/.config/dconf/user
	GNOME stores settings in dconf database. Copy it out to save keyboard shortcuts. (No idea how to just get those though. It's binary.)
	
	
	https://askubuntu.com/questions/787451/where-does-ubuntu-gnome-store-the-keyboard-shortcuts-configuration-file
	
	second answer lists dumping just keyboard shortcuts
	
	dconf dump / | sed -n '/\[org.gnome.settings-daemon.plugins.media-keys/,/^$/p' > custom-shortcuts.conf # Export
	
	dconf load / < custom-shortcuts.conf # Import
