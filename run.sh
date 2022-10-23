#!/bin/bash
set -e

mkdir -p build/

nasm -Wall -f bin boot.asm -o build/boot.bin
gcc -m32 -ffreestanding -nostdlib kernel.c -o build/kernel.o
objcopy -O binary build/kernel.o build/kernel.bin

cat build/boot.bin build/kernel.bin > build/os.bin
qemu-system-i386 -hda build/os.bin
