# Universal GMS Doze Fix

**中文文档**|[English](README_EN.md)

## 概述
 - 修复了Universal GMS Doze模块卸载不干净的问题
 - 修补Google Play服务应用程序和某些流程/服务，以便能够使用电池优化
 - 支持API 23或更高版本

## 故障排除
 - 检查优化的命令（已安装模块）：
 ``` 
 > su 
 > gmsc 
 ``` 
 - 检查优化的命令（一般情况下）：
有一行写着 `Whitelist (except idle) system apps:`，如果`com.google.android.gms` 行不存在，则意味着Google Play服务已优化

 ``` 
 > su 
 > dumpsys deviceidle 
 ``` 
 - 用于修复延迟传入消息问题的命令行：
如果问题仍然存在，请将应用程序移出电池优化
 ``` 
 > su 
 > cd /data/data 
 > find . -type f -name '*gms*' -delete 
 ``` 
 - 用于禁用查找我的设备的命令(可选)： 
 ``` 
 > su 
 > pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver 
 ``` 
  
## 贡献者
 - [@topjohnwu](https://github.com/topjohnwu)    
 Magisk - Magisk Module Template 
 - [@MrCarb0n](https://github.com/MrCarb0n)    
 Script / syntax helper
 - [@gloeyisk](https://github.com/gloeyisk)
 Universal Gms Doze