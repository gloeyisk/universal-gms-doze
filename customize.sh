#!/system/bin/sh

#
# Universal GMS Doze by the
# open source loving 'GL-DP' and all contributors;
# Optimized and adjusted Google Play services
#

# Checking for installation environment
sleep 1
if [ $BOOTMODE = true ]; then
 ROOT=$(find `magisk --path` -type d -name "mirror" | head -n 1)
ui_print "- Root path: $ROOT"
else
 ROOT=""
fi

# Check minimum API requirements
sleep 1
ui_print "- Checking API version" 
 if [ $API -ge 23 ]; then
sleep 1
ui_print "   Reached minimum API requirements"
sleep 1
ui_print "   Continue installation"
 break
 else
sleep 1
	ui_print "   Does not reached minimum API requirements"
sleep 1
	   abort "   Aborting"
 fi

# Patch the XML and place the modified one to the original directory
sleep 1
ui_print "- Patching needed files"
list=$(xml=$(find /system/ /product/ /vendor/ -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' $ROOT$i 2>/dev/null; then echo "$i";fi; done)
 for i in $list
 do
 mkdir -p `dirname $MODPATH$i`
 cp -af $ROOT$i $MODPATH$i
sleep 1
ui_print "   Searching in:"
sleep 1
ui_print "    $i"
sleep 1
 sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d' $MODPATH$i
ui_print "   Files found and patched"
 done

 for i in product vendor
 do
 if [ -d $MODPATH/$i ]; then
 if [ ! -d $MODPATH/system/$i ]; then
sleep 1
ui_print "- Moving /$i to system partition"
 mkdir -p $MODPATH/system/$i
 mv -f $MODPATH/$i $MODPATH/system/
 else
 rm -rf $MODPATH/$i
 fi
 fi
 done

# Search and patch any conflicting modules (if present)
# Search conflicting XML files
conflict=$(xml=$(find /data/adb -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' $i 2>/dev/null; then echo "$i";fi; done)
 for i in $conflict
 do
search=$(echo "$i" | sed -e 's/\// /g' | awk '{print $4}')
sleep 1
ui_print "- Conflicting modules detected"
sleep 1
ui_print "   Module: $search"
sleep 1
ui_print "   Searching in:"
sleep 1
ui_print "    $i"
sleep 1
 sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d' $i
ui_print "   Files found and patched"
 done

# Additional add-on for check GMS status
sleep 1
ui_print "- Inflating add-on file"
 mkdir -p $MODPATH/system/bin
 mv -f $MODPATH/gmsc $MODPATH/system/bin/gmsc
 chmod +x $MODPATH/system/bin/gmsc

# Clean up
sleep 1
ui_print "- Cleaning up"
 rm -rf $MODPATH/LICENSE

sleep 1
# Executing...
# Done
