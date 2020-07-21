/*
 * TMS9918A Hello World C example
 * 
 * Compile with z88dk: 
 * zcc +cpm -create-app -ohello hello.c tmsc.asm z180c.asm
 */

#include <stdio.h>
#include <stdint.h>
#include "font.h"
#include "tms.h"
#include "z180.h"

main()
{
	if (!TmsProbe()) {
		printf("TMS9918A not found, aborting!\n");
		return;
	}
	if (Z180Detect() != 0xFF) {
		TmsSetWait(Z180GetClock());
	} else {
		TmsSetWait(0);
	}
    TmsTextMode(font);
	TmsBackground(TMS_DARKBLUE);
	TmsTextColor(TMS_WHITE);
	TmsTextPos(0, 0);
	TmsStrOut("hello, world");
}