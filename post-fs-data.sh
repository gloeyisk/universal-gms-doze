#!/system/bin/sh

#
# Universal GMS Doze by the
# open source loving 'GL-DP' and all contributors;
# Conflict Checker v1.1
#

# Search and patch any conflicting modules (if present)
# Patch conflicting XML files
conflict=$(xml=$(find /data/adb -iname "*.xml");for i in $xml; do if grep -q 'allow-in-power-save package="com.google.android.gms"' $i 2>/dev/null; then echo "$i";fi; done)
 for i in $conflict
 do
 sed -i '/allow-in-power-save package="com.google.android.gms"/d;/allow-in-data-usage-save package="com.google.android.gms"/d' $i
 done

# Executing...
# Done
