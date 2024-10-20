#
# tmux
#

{ pkgs, ...}:

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
        unbind v   # Make sure nothing is using v
	unbind b   # Make sure nothing is used b
        unbind %   # Default to split vertically
	unbind '"' # Default to split horizontally

	bind v split-window -v -c "#{pane_current_path}"
	bind b split-window -h -c "#{pane_current_path}"
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = dracula;
	  extraConfig = ''
            set -g @dracula-show-battery false
	    set -g @dracula-show-powerline true
	    set -g @dracula-refresh-rate 10
	  '';
	}
      ];
    };
  };
}
