# Universal GMS Doze

## Overview:
- Optimized and adjusted Google Play services.
- Patching process is handled by a command script, which detects default file location and any conflicting modules.
- API 23 or later is supported.
- Magisk Live or Custom Recovery installations is supported.
- 100 seconds pause script for Magisk Boot Service.

## Contents:
- Base extensions   
add-on: 1.0 (0815)   
cc: 1.0 (0925)   
module: 1.8.1 (0925)   
code: 181  

## Troubleshooting:
- Command-line for fix delayed incoming messages issue:
```
> su
> cd /data/data
> find . -type f -name '*gms*' -delete
```
- Command-line for check optimization:   
There's a line written `Whitelist (except idle) system apps:` and if `com.google.android.gms` line does not exist it means Google Play services is optimized).
```
> su
> dumpsys deviceidle
```
- Command-line for disable Find My Device:
```
> su
> pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
```

## Credits:
- [@topjohnwu](https://github.com/topjohnwu) / Magisk - Magisk Module Template
- [@JumbomanXDA](https://github.com/JumbomanXDA) / Custom installation script

## Extras:
- Donation: [PayPal](https://paypal.me/gloeyisk)
- Mirror Links: [Telegram](https://t.me/gldppc) - [Sourceforge](https://bit.ly/3bm3ozq)
- Source Code: [GitHub](https://github.com/gloeyisk/UniversalGMSDoze)
