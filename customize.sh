#!/system/bin/sh

#
# Universal GMS Doze by the
# Open Source loving 'GL-DP' and all contributors;
# Optimized and adjusted Google Play services
#

# Check minimum API requirements
sleep 1
ui_print "- Checking API version..." 
sleep 1
if [ $API -ge 23 ]; then
ui_print "  - Reached minimum API requirements"
sleep 1
ui_print "  - Continue installation"
break
else
ui_print "   - Does not reached minimum API requirements"
sleep 1
	abort 	 "   - Aborting"
fi

# Patch the XML and placed the modified one to the original directory
sleep 1
ui_print "- Patching needed files..."
list=$(xml=$(find /system /vendor -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' /sbin/.magisk/mirror$i 2>/dev/null; then echo "$i";fi; done)
for i in $list
do
	mkdir -p `dirname $MODPATH$i`
sleep 1
ui_print "  - Searching in: $i"
sleep 1
ui_print "  - Files found and patched"
	cp -af /sbin/.magisk/mirror$i $MODPATH$i
	sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d;/allow-in-power-save package="com.google.android.ims"/d;/allow-in-power-save package="com.google.android.apps.turbo"/d' $MODPATH$i
done
mv -f $MODPATH/vendor $MODPATH/system/vendor

# A necessary add-on file which contains carefully, well-known modified services
sleep 1
ui_print "- Inflating add-on"
echo "#!/system/bin/sh

#
# Universal GMS Doze by the
# Open Source loving 'GL-DP' and all contributors;
# Add-on v1.0
#

if [ ! -d /data/adb/modules/UniversalGMSDoze ]; then
	rm -rf /data/adb/service.d/23-gldp.sh
fi

# Sleep before the script executed (in seconds)
sleep 100

# Disable collective Device administrators
pm disable com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

# Executing...
# Done
" > /data/adb/service.d/23-gldp.sh
chmod +x /data/adb/service.d/23-gldp.sh

# Clean up
sleep 1
ui_print "- Cleaning up"
clean_up() {
	rm -rf $MODPATH/LICENSE
}
clean_up

# Executing...
# Done
sleep 1
