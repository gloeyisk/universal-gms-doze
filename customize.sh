#!/sbin/sh

#
# Universal GMS Doze by the
# open source loving GL-DP and all contributors;
# Patches Google Play services app and its background processes to be able using battery optimization
#

# Checking for installation environment
if [ $BOOTMODE = true ]; then
ROOT=$(find `magisk --path` -type d -name "mirror" | head -n 1)
ui_print "- Root path: $ROOT"
else
ROOT=""
fi

# Check device SDK
sdk="$(getprop ro.build.version.sdk)"
if [[ !"$sdk" -ge "23" ]]; then
ui_print "- Unsupported SDK version: $sdk"
exit 1
fi

# Patch the XML and place the modified one to the original directory
ui_print "- Patching XML files"
location=$(xml=$(find /system/ /system_ext/ /product/ /vendor/ -iname "*.xml");for i in $xml; do if grep -q 'allow-unthrottled-location package="com.google.android.gms"' $ROOT$i 2>/dev/null; then echo "$i";fi; done)
ignore=$(xml=$(find /system/ /system_ext/ /product/ /vendor/ -iname "*.xml");for i in $xml; do if grep -q 'allow-ignore-location-settings package="com.google.android.gms"' $ROOT$i 2>/dev/null; then echo "$i";fi; done)

for i in $location $ignore
do
mkdir -p `dirname $MODPATH$i`
cp -af $ROOT$i $MODPATH$i
sed -i '/allow-unthrottled-location package="com.google.android.gms"/d;/allow-ignore-location-settings package="com.google.android.gms"/d' $MODPATH$i
done

for i in product vendor
do
if [ -d $MODPATH/$i ]; then
if [ ! -d $MODPATH/system/$i ]; then
sleep 1
ui_print "- Moving files to /system partition"
mkdir -p $MODPATH/system/$i
mv -f $MODPATH/$i $MODPATH/system/
else
rm -rf $MODPATH/$i
fi
fi
done

# Search and patch any conflicting modules (if present)
# Search conflicting XML files
conflict1=$(xml=$(find /data/adb -iname "*.xml");for i in $xml; do if grep -q 'allow-unthrottled-location package="com.google.android.gms"' $i 2>/dev/null; then echo "$i";fi; done)
conflict2=$(xml=$(find /data/adb -iname "*.xml");for i in $xml; do if grep -q 'allow-ignore-location-settings package="com.google.android.gms"' $i 2>/dev/null; then echo "$i";fi; done)
for i in $conflict1 $conflict2
do
search=$(echo "$i" | sed -e 's/\// /g' | awk '{print $4}')
ui_print "- Conflicting modules detected"
ui_print "   $search"
sed -i '/allow-unthrottled-location package="com.google.android.gms"/d;/allow-ignore-location-settings package="com.google.android.gms"/d' $i
done

# Additional add-on for check GMS status
ui_print "- Inflating add-on file"
mkdir -p $MODPATH/system/bin
mv -f $MODPATH/gmsc $MODPATH/system/bin/gmsc
chmod +x $MODPATH/system/bin/gmsc

# Clean up
rm -rf $MODPATH/LICENSE
