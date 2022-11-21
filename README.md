# Universal GMS Doze

---
## Overview
- Patches Google Play services app and its background processes to be able to use battery optimization
- Support API 23 or later
- Support Magisk Live or Custom Recovery installations

---
## Download Links (Archive)
- <img src="https://img.shields.io/badge/status:-available-green" />  
 
  - [GitHub Releases](https://kutt.it/c7fx04)   
  - [Sourceforge](https://kutt.it/9sKLvQ)      

---
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
If the issue still persist, put the app to Not Optimized battery usage.
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

---
## Credits
- [@topjohnwu](https://github.com/topjohnwu) / Magisk - Magisk Module Template
- [@JumbomanXDA](https://github.com/JumbomanXDA) / Custom installation script
- [@MrCarb0n](https://github.com/MrCarb0n) / Code rebase, overall code quality & syntax

---
## Extras
- Donations: [PayPal](https://paypal.me/gloeyisk) - [LiberaPay](https://liberapay.com/gloeyisk) - [Ko-fi](https://ko-fi.com/gloeyisk)
- Source Code: [GitHub](https://github.com/gloeyisk/universal-gms-doze)
- Support Thread: [XDA Developers](https://forum.xda-developers.com/apps/magisk/module-universal-gms-doze-t3853710)
