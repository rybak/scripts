lspci -nn | grep -E 'VGA|Display'
grep -i switcheroo /boot/config-*
sudo cat /sys/kernel/debug/vgaswitcheroo/switch
sudo lshw -C video -C cpu
glxheads
# https://wiki.archlinux.org/index.php/PRIME
DRI_PRIME=1 glxheads
