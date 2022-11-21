#!/data/adb/magisk/busybox sh
set -o standalone

set -x

#
# Universal GMS Doze by the
# open source loving GL-DP and all contributors;
# Patches Google Play services app and its background
# processes to be able to use battery optimization
#

# Checking for installation environment
if [ $BOOTMODE = true ]; then
    ui_print "- Finding root path"
    ROOT="$(find "$(magisk --path)" -maxdepth 2 -type d -name "mirror" -print)"
    ui_print "  Path: $ROOT"
else
    unset ROOT
fi

# Check Android API
[ $API -ge 23 ] ||
    abort "- Unsupported API version: $API"

# Patch the xml and place the modified one to the original directory
ui_print "- Patching XML files"

{
    GMS0="\"com.google.android.gms"\"
    STR1="allow-unthrottled-location package=$GMS0"
    STR2="allow-ignore-location-settings package=$GMS0"
    STR3="allow-in-power-save package=$GMS0"
    STR4="allow-in-data-usage-save package=$GMS0"
    NULL="/dev/null"
}

ui_print "- Finding system XML"
SYS_XML="$(
    SXML="$(find /system_ext/* /system/* /product/* \
                 /vendor/* -type f -iname '*.xml' -print)"
    for S in $SXML; do
        if grep -qE "$STR1|$STR2|$STR3|$STR4" $ROOT$S 2> $NULL; then
            echo "$S"
        fi
    done
)"

PATCH_SX() {
    for SX in $SYS_XML; do
        mkdir -p "$(dirname $MODPATH$SX)"
        cp -af $ROOT$SX $MODPATH$SX
        ui_print "  Patching: $SX"
        sed -i "/$STR1/d;/$STR2/d;/$STR3/d;/$STR4/d" $MODPATH/$SX
    done

    # Merge patched files under /system dir
    for P in product vendor; do
        if [ -d $MODPATH/$P ]; then
            ui_print "- Moving files to module dir"
            mkdir -p $MODPATH/system/$P
            mv -f $MODPATH/$P $MODPATH/system/
        fi
    done
}

# Search and patch any conflicting modules (if present)
# Search conflicting XML files
MOD_XML="$(
    MXML="$(find /data/adb/* -type f -iname "*.xml" -print)"
    for M in $MXML; do
        if grep -qE "$STR1|$STR2|$STR3|$STR4" $M; then
            echo "$M"
        fi
    done
)"

PATCH_MX() {
    ui_print "- Finding conflicting XML"
    for MX in $MOD_XML; do
        MOD="$(echo "$MX" | awk -F'/' '{print $5}')"
        ui_print "  $MOD: $MX"
        sed -i "/$STR1/d;/$STR2/d;/$STR3/d;/$STR4/d" $MX
    done
}

# Find and patch conflicting XML
PATCH_SX && PATCH_MX

# Additional add-on for check gms status
ADDON() {
    ui_print "- Inflating add-on file"
    mkdir -p $MODPATH/system/bin
    mv -f $MODPATH/gmsc $MODPATH/system/bin/gmsc
}

FINALIZE() {
    ui_print "- Finalizing installation"

    # Clean up
    ui_print "  Cleaning obsolete files"
    find $MODPATH/* -maxdepth 0 \
                  ! -name 'module.prop' \
                  ! -name 'post-fs-data.sh' \
                  ! -name 'service.sh' \
                  ! -name 'system' \
                    -exec rm -rf {} \;

    # Settings dir and file permission
    ui_print "  Settings permissions"
    set_perm_recursive $MODPATH 0 0 0755 0755
    set_perm $MODPATH/system/bin/gmsc 0 2000 0755
}

# Final adjustment
ADDON && FINALIZE