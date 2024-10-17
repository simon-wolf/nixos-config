#
# tmux
#

{
  programs = {
    tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      escapeTime = 1;
      terminal = "screen-256color";
      extraConfig = ''
        # Use v and b to split vertically and horizontally (matching Sway)
        unbind v
	unbind b
        unbind %
	# Split vertically
	unbind '"' # Split horizontally

	bind v split-window -v -c "#{pane_current_path}"
	bind b split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
