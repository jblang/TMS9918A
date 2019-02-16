#include <stdint.h>
#include "font.h"
#include "tms.h"

main()
{
    tmstextmode(font);
	tmsbackground(TMS_DARKBLUE);
	tmstextcolor(TMS_WHITE);
	tmstextpos(0, 0);
	tmsstrout("hello, world");
}