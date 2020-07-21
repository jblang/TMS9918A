/*
 * Hopalong Attractor for RC2014 with TMS9918A video card
 * 
 * https://brainwagon.org/2011/03/24/hopalong-from-dewdneys-armchair-universe/
 * 
 * Compile with z88dk: 
 * zcc +cpm --math32 -create-app -ohopalong hopalong.c tmsc.asm z180c.asm
 * 
 * For Z180 hardware multiply, add -mz180:
 * zcc +cpm --math32 -mz180 -create-app -ohopalong hopalong.c tmsc.asm z180c.asm
 * 
 * Press ESC to quit; any other key to get a new image.
 */

#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include "tms.h"
#include "z180.h"

#define ESC 27
#define frand() ((float)rand()/RAND_MAX)

main()
{

	if (!TmsProbe()) {
		printf("TMS9918A not found, aborting!\n");
		return;
	}
	uint8_t cmr, ccr, dcntl;
	uint8_t z180base = Z180Detect();
	if (z180base != 0xFF) {
		cmr = Z180Read(Z180_CMR);
		ccr = Z180Read(Z180_CCR);
		dcntl = Z180Read(Z180_DCNTL);
		// Uncomment to use fast clock; doubles serial baud rate so not enabled by default
		/*
		Z180SetMemWait(1);
		Z180SetIOWait(3);
		Z180ClockFast();
		*/
		TmsSetWait(Z180GetClock());
	} else {
		TmsSetWait(0);
	}
	printf(
		"Hopalong Attractor\n"
		"Press ESC to quit, any other key for new random parameters.\n\n");

	do {
		TmsBitmap();
		int color = frand()*13 + 2;
		TmsFill(TMS_FGBG(color, TMS_BLACK), TMS_BITMAPCOLORTBL, TMS_BITMAPCOLORLEN);
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
				TmsPlotPixel(sx, sy);
		}
	} while (getch() != ESC);
	// restore registers to original values
	if (z180base != 0xFF) {
		Z180Write(Z180_CMR, cmr);
		Z180Write(Z180_CCR, ccr);
		Z180Write(Z180_DCNTL, dcntl);
	}
}