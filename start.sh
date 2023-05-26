
function start_hda(){
	qemu-system-x86_64 \
	-m 512M \
	-kernel ./bzImage \
	-hda  ./rootfs \
	-append "root=/dev/sda rdinit=/linuxrc console=ttyS0" \
	-nographic 
}

function start_initrd(){
	qemu-system-x86_64  \
	-m 512M \
	-kernel ./bzImage \
	-initrd rootfs.cpio \
	-nographic \
	-append "rdinit=/linuxrc console=ttyS0 quiet kaslr"
}

#start_hda
start_initrd
