qemu-system-x86_64 \
-m 512M \
-kernel ./bzImage \
-hda  ./rootfs \
-append "root=/dev/sda rdinit=/linuxrc console=ttyS0" \
-nographic 
