// volatile is used so the compiler doesn't optimize away my gorgeous and flamboyant code

typedef unsigned char u8;

void _start() {
	volatile u8* vram = (volatile u8*)0xb8000;
	volatile u8* null = (volatile u8*)0;

	vram[0] = 'R';

	*null = 13; // 13 is light purple
	vram[1] = *null;

	while (1);
}
