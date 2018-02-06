# rc9918

TMS9981A-based video card for the RC2014. Currently this is a completely untested KiCad schematic and PCB layout, so manufacture PCBs based on this at your own risk.  I have to place a Mouser order for some additional components and breadboard the circuit before I'll place my first PCB order.

TMS9918 manual here: http://map.grauw.nl/resources/video/texasinstruments_tms9918.pdf

This is based on a circuit described by Tom LeMense for interfacing the TMS9918A with SRAM: https://retrobrewcomputers.org/n8vem-pbwiki-archive/0/35845334/48860720/33053543/SRAM%20Replacement%20for%20TMS99x8%20VRAM.pdf.

If I've done the decoding properly, the TMS9918 should map to ports 90-9F. Only two ports are actually used but I couldn't figure out a way to map fewer ports without adding another chip, and the PCB is pretty crowded already.  Even ports should map to the TMS9918's data port and odd ports should map to the address/status port. Since the original MSX had the TMS9918A mapped to ports 98 and 99, this port layout should hopefully be compatible with software written for the MSX.
