#!/system/bin/sh

#
# Universal GMS Doze by the
# open source loving 'GL-DP' and all contributors;
# DeviceAdmin Disabler v1.2
#

# Check if boot completed (in seconds)
while [ "$(getprop sys.boot_completed)" != "1" ]; do
	sleep 1
done

# Sleep before the script executed (in seconds)
sleep 100

# Multi User Support
for i in $(ls /data/user/)
do
 # Disable collective Device administrators
 pm disable --user $i com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
 pm disable --user $i com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

 # Disable both GMS and IMS 'Modify system settings' and restart it on boot
 cmd appops set --user $i com.google.android.gms WRITE_SETTINGS ignore
 cmd appops set --user $i com.google.android.ims WRITE_SETTINGS ignore

 # Disable both GMS and IMS 'Run in startup' and restart it on boot
 cmd appops set --user $i com.google.android.gms BOOT_COMPLETED ignore
 cmd appops set --user $i com.google.android.ims BOOT_COMPLETED ignore
	
 # Disable both GMS and IMS 'Run in startup' and restart it on boot (custom permissions for Oxygen OS)
 cmd appops set --user $i com.google.android.gms AUTO_START ignore
 cmd appops set --user $i com.google.android.ims AUTO_START ignore
done

# Executing...
# Done

exit 0
