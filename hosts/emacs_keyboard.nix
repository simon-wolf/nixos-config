#
# emacs keyboard modifications
# https://github.com/rvaiya/keyd
#

{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control, esc)"; # Map to control when held, esc when pressed
          };
        };
      };
    };
  };
}

