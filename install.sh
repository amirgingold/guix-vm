# is_vm () { dmesg | grep -q 'Hypervisor detected'; }

device=/dev/sda

# Partitioning
boot_partition="$device"1
swap_partition="$device"2
root_partition="$device"3
  
sfdisk "$device" << EOF
,1G,83
,10G,82
,,
EOF

# Formatting
mkfs.fat -F32 "$boot_partition"
mkswap "$swap_partition"; swapon "$swap_partition"
mkfs.ext4 -F -F "$root_partition"

# Labeling
fatlabel "$boot_partition" BOOT
e2label "$root_partition" ROOT

# Mounting
mount "$root_partition" /mnt
mkdir /mnt/boot
mount "$boot_partition" /mnt/boot

# Installing
herd start cow-store /mnt
mkdir -p /root/.config/guix
wget https://github.com/amirgingold/guix-vm/raw/main/channels.scm --directory-prefix=/root/.config/guix
guix pull
hash guix
wget https://github.com/amirgingold/guix-vm/raw/main/config.scm
guix system init config.scm /mnt
