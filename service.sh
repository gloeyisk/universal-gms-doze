#!/sbin/sh

# Check if boot completed (in seconds)
while [ "$(getprop sys.boot_completed)" != "1" ]; do
	sleep 1
done

# Sleep before the script executed (in seconds)
    sleep 120

# Multi User Support
for i in $(ls /data/user/)
 do
# Disable collective Device administrators
pm disable --user $i com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
 done

exit 0
