People always say to be careful not to derefrence a pointer that points to address 0 because then your program will crash, well they didn't do their research properly

# What
this code writes to address 0 and then reads it and just writes a purple character on screen. (check kernel.c)

# How to run
first install qemu (qemu.org) or your favourite virtualization tool
then look at the last line in run.sh

# How to build from source yourself
you need nasm and gcc, and just use the script run.sh
