#
# neomutt
#

{
  programs = {
    neomutt = {
      enable = true;
      vimKeys = false;
      sidebar = {
        enable = true;
	format = "%B%?F? [%F]?%* %?N?%N/?%S";
	shortPath = true;
      };
      sort = "reverse-date-received";
      extraConfig = ''
	# cache settings
	set header_cache = "~/mail/fastmail/cache/headers"
	set message_cachedir = "~/mail/fastmail/cache/bodies"
        
	# navigation settings

	# synchronisation settings
	macro index S "<shell-escape>mbsync -V fastmail<enter>" "sync email"

	# misc settings
        set mail_check_stats

	# default index colour settings
	color index yellow default ".*"
	color index_author red default ".*"
        color index_number blue default ".*"
        color index_subject cyan default ".*"

        # new mail colour settings
        color index brightyellow black "~N"
        color index_author brightred black "~N"
        color index_subject brightcyan black "~N"
      '';
    };
  };
}
