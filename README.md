# ipswlist
Lookup ipsw restore file links by device and iOS version and download all versions

Setup:
  chmod +x ipswget.sh
  move ipswget.sh to your PATH or your firmware storage folder.

  When I am using Apple Configurator 2, I manage firmware in the following location since AC2 *should* be able to see it cached there.

  ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/

  I also symlink it to an easier filesystem location for regular use.
    ie:   ls -s ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/ /Users/Shared/acFirmware/

USAGE:
	Run ipswget without and inputs to view the usage info.

          ____ ____  _____ _       __          ______ ______ ______
         /  _// __ \/ ___/| |     / / ../..   / ____// ____//_  __/
         / / / /_/ /\__ \ | | /| / / (    (  / / __ / __/    / /
       _/ / / ____/___/ / | |/ |/ /   \_._/ / /_/ // /___   / /
      /___//_/    /____/  |__/|__/          \____//_____/  /_/


	ipswget version 1.0.1 2017-09-15 10:29:00 AM PDT
	(c) dkmansion 2016-2017
	Purpose:        Query Apple for current IPSW (iOS Restore) file list based
	                on supplied version number, and optionally download the files.

	Usage:
	        [options][arguments]

	Options:
	    -v  Apple iOS version number to retrieve (argument as tuple ie. 1.2.3)
	    -d  Devices to download the ipsw files for as OCTAL sums. (see arguments)
	    -p  Path for working downloads.

	Arguments:
	  for option
	    v   tuple representing iOS version number 10.1.2 or 9.1, etc.
	    d   Summed OCTAL mimicking chmod permission numbering.
	      0  -- DOES NOT download any files except the list
	      1  -- gets iPad ipsws
	      2  -- gets iPhone ipsws
	      3  -- gets iPad & iPhone ipsws
	      4  -- gets iPod ipsws
	      5  -- gets iPad & iPod ipsws
	      6  -- gets iPhone & iPod ipsws
	      7  -- gets All (iPad, then iPhone, then iPod) ipsws

	    p   Valid file path where you want to download the files.
	        	ie ~/downloads

	Examples:
	        Get the list for 10.3.1, and DOES NOT DOWNLOAD ANY ipsw files (-d = 0)
	        ipswget -d 0 -v 10.3.1 -p ~/Downloads

	        Get the list for 10.3.2 and downloads all iPad ipsws to ~/downloads (-d = 1)
	        ipswget -d 1 -v 10.3.2 -p ~/downloads

	        Get the list for 10.3.2 and downloads all iPad ipsws to current directory (missing -p)
	        ipswget -d 1 -v 10.3.2

|- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

NOTE: ipsws downloaded are ~2.5GB each.
