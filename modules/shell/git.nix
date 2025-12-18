#
# Git
#

{
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "name";
        user.email = "swolf@fastmail.co.uk";
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
  };
}
