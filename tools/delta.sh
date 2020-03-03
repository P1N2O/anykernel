#!/sbin/sh

LD_PATH=/system/lib
if [ -d /system/lib64 ]; then
  LD_PATH=/system/lib64
fi

exec_util() {
  LD_LIBRARY_PATH=/system/lib64 $UTILS $1
}

# Mount vendor if unmounted : Start Mods
umount /vendor || true
mount -o rw /dev/block/bootdevice/by-name/vendor /vendor
# Copy modified fstab with f2fs mount points and encryptable flags
ui_print " " "Adding F2FS mount points (data & cache)...";
chmod -R 644 /tmp/anykernel/ramdisk/fstab.qcom;
exec_util "cp -af /tmp/anykernel/ramdisk/fstab.qcom /vendor/etc/"
rm $ramdisk/fstab.qcom
# Copy modifiede thermals for less agressive throttling
ui_print " " "Modifying stock thermals to be less agressive...";
chmod -R 644 /tmp/anykernel/mods/thermal-engine;
chmod -R 644 /tmp/anykernel/mods/thermal-engine.conf;
exec_util "cp -af /tmp/anykernel/mods/thermal-engine /vendor/etc/"
exec_util "cp -af /tmp/anykernel/mods/thermal-engine.conf /vendor/etc/"
# Unmount vendor if mounted : End Mods
umount /vendor || true
