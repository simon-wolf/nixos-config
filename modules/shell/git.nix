#
# Git
#

{
  programs = {
    git = {
      enable = true;
      userName = "Simon Wolf";
      userEmail = "swolf@fastmail.co.uk";
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
  };
}
