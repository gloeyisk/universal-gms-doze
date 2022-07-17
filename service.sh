#!/sbin/sh

# Sleep before the script executed (in seconds)
sleep 110

# Multi User Support
for i in $(ls /data/user/)
do
# Disable collective Device administrators
pm disable com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
done

exit 0
