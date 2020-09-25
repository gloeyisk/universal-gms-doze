#!/system/bin/sh

#
# Universal GMS Doze by the
# Open-Source loving 'GL-DP' and all contributors;
# Optimized and adjusted Google Play services
#

# Installation environments
sleep 1
if [ $BOOTMODE = true ]; then
ui_print "- Magisk Live installation mode"
ROOT="/sbin/.magisk/mirror"
else
ui_print "- Custom Recovery installation mode"
ROOT=""
fi

# Check minimum API requirements
sleep 1
ui_print "- Checking API version" 
sleep 1
if [ $API -ge 23 ]; then
ui_print "   Reached minimum API requirements"
sleep 1
ui_print "   Continue installation"
break
else
ui_print "   Does not reached minimum API requirements"
sleep 1
abort 	 "   Aborting"
fi

# Patch the XML and place the modified one to the original directory
sleep 1
ui_print "- Patching needed files"
list=$(xml=$(find /system /vendor -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' $ROOT$i 2>/dev/null; then echo "$i";fi; done)
for i in $list
do
mkdir -p `dirname $MODPATH$i`
sleep 1
ui_print "   Searching in: $i"
sleep 1
ui_print "   Files found and patched"
cp -af $ROOT$i $MODPATH$i
sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d' $MODPATH$i
done
if [ -d $MODPATH/vendor ]; then
	mv -f $MODPATH/vendor $MODPATH/system/vendor
fi

# Search and patch any conflicting modules (if present)
# Part 1 - Handle conflicting modules while installing this module
conflict=$(xml=$(find /data/adb -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' $i 2>/dev/null; then echo "$i";fi; done)
for i in $conflict
do
search=$(echo "$i" | sed -e 's/\// /g' | awk '{print $4}')
sleep 1
ui_print "- Conflicting modules detected"
sleep 1
ui_print "   Module: $search"
sleep 1
ui_print "   Searching in: $i"
sleep 1
ui_print "   Files found and patched"
sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d' $i
done

# Part 2 - Handle conflicting modules when getting updates
sleep 1
ui_print "- Inflating conflict checker"
echo "#!/system/bin/sh

#
# Universal GMS Doze by the
# Open-Source loving 'GL-DP' and all contributors;
# Conflict Checker v1.0
#

if [ ! -d /data/adb/modules/UniversalGMSDoze ]; then
rm -rf /data/adb/post-fs-data.d/cc-gldp.sh
fi

# Check any conflicting modules (if present)
conflict=\$(xml=\$(find /data/adb -iname \"*.xml\");for i in \$xml; do if grep -q 'allow-in-power-save package=\"com.google.android.gms\"' \$i 2>/dev/null; then echo \"\$i\";fi; done)
for i in \$conflict
do
sed -i '/allow-in-power-save package=\"com.google.android.gms\"/d;/allow-in-data-usage-save package=\"com.google.android.gms\"/d' \$i
done

# Executing...
# Done
" > /data/adb/post-fs-data.d/cc-gldp.sh
chmod +x /data/adb/post-fs-data.d/cc-gldp.sh

# A necessary add-on file which contains carefully, well-known modified services
sleep 1
ui_print "- Inflating add-on"
echo "#!/system/bin/sh

#
# Universal GMS Doze by the
# Open-Source loving 'GL-DP' and all contributors;
# Add-on v1.0
#

if [ ! -d /data/adb/modules/UniversalGMSDoze ]; then
rm -rf /data/adb/service.d/ao-gldp.sh
fi

# Sleep before the script executed (in seconds)
sleep 100

# Disable collective Device administrators
pm disable com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

# Executing...
# Done
" > /data/adb/service.d/ao-gldp.sh
chmod +x /data/adb/service.d/ao-gldp.sh

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
