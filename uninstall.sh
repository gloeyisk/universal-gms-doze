#!/system/bin/sh

#
# Universal GMS Doze by the
# open-source loving GL-DP and all contributors;
# Patches Google Play services app and certain processes/services to be able to use battery optimization
#

# GMS components
GMS="com.google.android.gms"
GC1="auth.managed.admin.DeviceAdminReceiver"
GC2="mdm.receivers.MdmDeviceAdminReceiver"
NLL="/dev/null"

# Enable collective device administrators
for U in $(ls /data/user); do
for C in $GC1 $GC2 $GC3; do
pm enable --user $U "$GMS/$GMS.$C" &> $NLL
done
done

# Remove GMS to battery optimization
dumpsys deviceidle whitelist +com.google.android.gms &> $NLL

exit 0
)

# Remove all module files after un-installation
rm -rf /data/adb/universal-gms-doze
