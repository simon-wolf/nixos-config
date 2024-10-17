#
# Email accounts
#

{
  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts.fastmail = {
        primary = true;
	realName = "Simon Wolf";
	flavor = "fastmail.com";
        userName = "swolf@fastmail.co.uk";
        passwordCommand = "pass Personal/Fastmail";
        address = "swolf@fastmail.co.uk";
	maildir = {
	  path = "fastmail";
	};
	folders = {
          inbox = "INBOX";
	  drafts = "Drafts";
	  sent = "Sent Items";
	  trash = "Trash";
	};
	msmtp = {
	  enable = true;
	};
	neomutt = {
          enable = true;
	  sendMailCommand = "msmtp -a fastmail";
	};
      };
    };
  };
}
