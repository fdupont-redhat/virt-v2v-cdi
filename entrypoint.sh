#!/usr/bin/env bash

echo "Run virt-v2v with the following input:"
cat /mnt/v2v/input.xml

virt-v2v -v -x -i libvirtxml -o null --debug-overlays --no-copy /mnt/v2v/input.xml
[ $? != 0 ] && exit 1

echo "Conversion successful. Committing all overlays to local disks."
find /var/tmp -name 'v2v-*.qcow2' -exec qemu-img commit -p {} \;
[ $? != 0 ] && exit 1

echo "Commit successful. Cleaning up."
find /var/tmp -name 'v2v-*.qcow2' -exec rm -f {} \;

exit 0
