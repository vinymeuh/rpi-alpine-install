# Firmware for rtl8188eu Wifi dongle

Firmware file is available on Kernel.org: [rtl8188eufw.bin](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtlwifi/rtl8188eufw.bin)

Then it has to be integrated to the Alpine Linux provided modloop file (see ```boot/modloop-rpi2```):

On a ArchLinux box:

```
% file modloop-rpi2   
modloop-rpi2: Squashfs filesystem, little endian, version 4.0, xz compressed, 26424188 bytes, 2217 inodes, blocksize: 131072 bytes, created: Fri Nov 19 17:27:21 2021
```

1. Use overlayfs to mount the modloop file

```
mv modloop-rpi2 modloop-rpi2.ALPINE
mkdir lower upper work merged
sudo mount -o loop,rw modloop-rpi2.ALPINE lower
sudo mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work overlay merged
```

2. Copy ```rtl8188eufw.bin``` in ```merged/modules/merged/modules/firmware/rtlwifi```

3. Create new modloop file using XZ compression

```
sudo pacman squashfs-tools
sudo mksquashfs merged modloop-rpi2 -comp xz 
```

4. And finally copy new modloop file in the ```boot``` directory of the SD card
