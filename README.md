# ipswlist
Lookup ipsw restore file links by device and iOS version and download all versions

Setup:
  chmod +x ipswget.sh
  Move ipswlist.sh to PATH or your firmware storage folder.
  
  When I am using Apple Configurator 2, I manage firmware in the following location since AC2 *should* be able to see it cached there.
  
  ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/
  
  I also symlink it to an easier filesystem location for regular use. 
    ie:   ls -s ~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware/ /Users/Shared/acFirmware/
    
USAGE:
  If script is in your PATH
    ipswget.sh "{ipws version number}"
    ie.   ipswget.sh 10.2.1
  
  or if running from your firmware folder location
    ./ipswget.sh "{ipsw versionNumber}"
    ie.   ./ipswget.sh 10.2.1
    
Next Steps:
  Uncomment "open" or "for" lines to automatically view or download the actual ipsw files.
  
NOTE: ipsws downloaded are ~2.5GB each.
    
