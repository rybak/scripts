lspci -nn | grep -E 'VGA|Display'
grep -i switcheroo /boot/config-*
sudo cat /sys/kernel/debug/vgaswitcheroo/switch
sudo lshw -C video -C cpu
