# rc9918

TMS9981A-based video card for the RC2014. I have breadboarded the circuit and confirmed that it works; however, the PCB layout is currently untested, so manufacture at your own risk.

This is based on a circuit described by Tom LeMense for interfacing the TMS9918A with SRAM: https://retrobrewcomputers.org/n8vem-pbwiki-archive/0/35845334/48860720/33053543/SRAM%20Replacement%20for%20TMS99x8%20VRAM.pdf.

The TMS9918 data and control ports map to 98 and 99, respectively. Since the original MSX had the TMS9918A mapped to the same ports, this should hopefully be compatible with some software written for the MSX.

TMS9918 manual here: http://map.grauw.nl/resources/video/texasinstruments_tms9918.pdf
