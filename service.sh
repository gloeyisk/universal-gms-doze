#!/data/adb/magisk/busybox sh
set -o standalone

#
# Universal GMS Doze by the
# open source loving GL-DP and all contributors;
# Patches Google Play services app and its background
# processes to be able to use battery optimization
#

(   
    # Wait until boot completed
    until [ $(resetprop sys.boot_completed) -eq 1 ] &&
        [ -d /sdcard ]; do
        sleep 100
    done

    # GMS components
    GMS="com.google.android.gms"
    GC1="auth.managed.admin.DeviceAdminReceiver"
    GC2="mdm.receivers.MdmDeviceAdminReceiver"
    GC3="chimera.GmsIntentOperationService"
    NLL="/dev/null"

    # Disable collective device administrators
    for U in $(ls /data/user); do
        for C in $GC1 $GC2 $GC3; do
            pm disable --user $U "$GMS/$GMS.$C" &> $NLL
        done
    done

    # Add GMS to battery optimization
    dumpsys deviceidle whitelist -com.google.android.gms &> $NLL

    exit 0
)