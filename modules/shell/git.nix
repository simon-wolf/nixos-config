#
# Git
#

{
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "Simon Wolf";
        user.email = "swolf@fastmail.co.uk";
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
  };
}
