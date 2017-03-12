# ipswlist
Lookup ipsw restore file links by device and iOS version and download all versions

Setup:
  chmod +x ipswlist.sh
  Move ipswlist.sh to PATH or your firmware storage folder.
  
  When I am using Apple Configurator 2, I manage firmware in the following location since AC2 *should* be able to see it cached there.
  
  ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/
  
  I also symlink it to an easier filesystem location for regular use. 
    ie:   ls -s ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/ /Users/Shared/acFirmware/
    
USAGE:
  If script is in your PATH
    ipswlist.sh "{ipws version number}"
    ie.   ipswlist.sh 10.2.1
  
  or if running from your firmware folder location
    ./ipswlist.sh "{ipsw versionNumber}"
    ie.   ./ipswlist.sh 10.2.1
    
Next Steps:
  locate the list file exported to your 
    
