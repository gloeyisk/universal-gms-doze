# Universal GMS Doze

## Overview:
- Optimized and adjusted Google Play services.
- Support API 23 or later.
- Support Magisk Live or Custom Recovery installations.

## Contents:
- Base extensions   
module: 1.8.4 (0830)   
code: 184   

## Troubleshooting:
- Command-line for check optimization (with add-on installed):
```
> su
> gmsc
```
- Command-line for check optimization (general):   
There's a line written `Whitelist (except idle) system apps:` and if `com.google.android.gms` line does not exist it means Google Play services is optimized).
```
> su
> dumpsys deviceidle
```
- Command-line for fix delayed incoming messages issue:
```
> su
> cd /data/data
> find . -type f -name '*gms*' -delete
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
- Donation: [PayPal](https://paypal.me/gloeyisk) - [LiberaPay](https://liberapay.com/gloeyisk)
- Mirror Links: [Telegram](https://t.me/gldppc) - [Index](https://kutt.it/Wt3rr4)
- Source Code: [GitHub](https://github.com/gloeyisk/universal-gms-doze)
- Support Thread: [XDA-Developers](https://forum.xda-developers.com/apps/magisk/module-universal-gms-doze-t3853710)
