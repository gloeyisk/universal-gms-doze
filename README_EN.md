# Universal GMS Doze Fix

[Chinese](README.md)|**English**

 ## Overview 
 - Fixed the problem of unclean uninstallation of Universal GMS Doze module
 - Patches Google Play services app and certain processes/services to be able to use battery optimization 
 - Support API 23 or later 
  
## Troubleshootings 
 - Command-line for check optimization (with module installed): 
 ``` 
 > su 
 > gmsc 
 ``` 
 - Command-line for check optimization (in general):    
 There's a line written `Whitelist (except idle) system apps:` and if `com.google.android.gms` line does not exist it means Google Play services is optimized). 
 ``` 
 > su 
 > dumpsys deviceidle 
 ``` 
 - Command-line for fix delayed incoming messages issue:    
 If the issue still persist, move the app to Not Optimized battery usage. 
 ``` 
 > su 
 > cd /data/data 
 > find . -type f -name '*gms*' -delete 
 ``` 
 - Command-line for disable Find My Device (optional): 
 ``` 
 > su 
 > pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver 
 ``` 
  
## Credits 
 - [@topjohnwu](https://github.com/topjohnwu)    
 Magisk - Magisk Module Template 
 - [@MrCarb0n](https://github.com/MrCarb0n)    
 Script / syntax helper 
 - [@gloeyisk](https://github.com/gloeyisk)
 Universal Gms Doze