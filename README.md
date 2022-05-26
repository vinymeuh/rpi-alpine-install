# rpi-alpine-install

## Basic apkovl file tree

```
.
└── etc
    ├── .default_boot_services
    ├── local.d
    │   └── bootstrap.start
    └── runlevels
        └── default
            └── local -> /etc/init.d/local

4 directories, 3 files
```

* ```.default_boot_services```  activate the standard Alpine Linux bootstrap mecanism

Extract from [https://pi3g.com/2019/01/22/debugging-the-alpine-boot-process/](https://pi3g.com/2019/01/22/debugging-the-alpine-boot-process/):

```
if the file $sysroot/etc/.default_boot_services exists or the apkovl location is not a file, then default boot services will be set up, and the file will be removed (so it will not be persisted in the apkovl when you do lbu commit)
```

* the symbolic link ```/etc/init.d/local``` enable the **local** service which will run all ```*.start``` executable files under ```/etc/local.d``` (sequentially and in alphabetical order).

* ```bootstrap.start``` run all my custom bootsrap actions. Like the standard Alpine Linux bootstrap mecanism, it must auto disable himself at the end to not be persisted.

```
rc-update del local
chmod a-x /etc/local.d/bootstrap.start
```

## Wifi configuation

Create a the root of the SD card the file **wifi.txt** with format:

```
ssid psk
```

For psk:

```
# wpa_passphrase SSID
reading passphrase from stdin
...
```

/etc/conf.d/wpa_supplicant

wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf  -Dwext -iwlan0

## References

* https://wiki.alpinelinux.org/wiki/Raspberry_Pi_-_Headless_Installation
* https://pi3g.com/2019/01/10/alpine-boot-process-on-the-raspberry-pi/
* https://pi3g.com/2019/01/22/debugging-the-alpine-boot-process/
* https://wiki.archlinux.org/title/Overlay_filesystem
