/*
 * Hopalong Attractor for RC2014 with TMS9918A video card
 * 
 * https://brainwagon.org/2011/03/24/hopalong-from-dewdneys-armchair-universe/
 * 
 * Compile with z88dk: 
 * zcc +cpm -lm -create-app -ohopalong hopalong.c tmsc.asm
 * 
 * Press ESC to quit; any other key to get a new image.
 */

#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include "tms.h"

#define ESC 27
#define frand() ((float)rand()/RAND_MAX)

main()
{
	printf(
		"Hopalong Attractor\n"
		"Press ESC to quit, any other key for new random parameters.\n\n");

	do {
		tmsbitmap();
		int color = frand()*13 + 2;
		tmsfill(TMS_FGBG(color, TMS_BLACK), TMS_BITMAPCOLORTBL, TMS_BITMAPCOLORLEN);
		float a = frand()*100 - 50;
		float b = frand()*100 - 50;
		float c = frand()*100 - 50;
		printf("a = %f, b = %f, c = %f\n", a, b, c);
		float x = 0, y = 0;
		while(!kbhit()) {
			float x0 = x;
			if	(x < 0)
				x = y + sqrt(fabs(b*x-c));
			else
				x = y - sqrt(fabs(b*x-c));
			y = a - x0;
			uint16_t sx = 127+x, sy = 95+y;
			if (sx < 256 && sy < 192)
				tmsplotpixel(sx, sy);
		}
	} while (getch() != ESC);
}