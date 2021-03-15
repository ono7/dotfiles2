# compress vms with 7z for max space savings

7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on win_x_base.7z vm_directory

# files needed for vmware image

*.vmdk
*.nvram
*.vmsd
*.vmx
*.vmxf

# SETUP SHARED FOLDER BETWEEN  (HOST) AND KALI 2 (ON VMWARE)

  mkdir -p /mnt/hgfs
  sudo apt-get update && sudo apt-get install open-vm-tools-desktop fuse
  reboot
