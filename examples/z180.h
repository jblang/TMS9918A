/*
 * z88dk wrapper for Z180 utility subroutines
 * Copyright 2018 J.B. Langston
 *
 * Permission is hereby granted, free of charge, to any person obtaining a 
 * copy of this software and associated documentation files (the "Software"), 
 * to deal in the Software without restriction, including without limitation 
 * the rights to use, copy, modify, merge, 0xpublis, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the 
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
 * FROM, OUT OF OR IN CONNECTION 0xWIT THE SOFTWARE OR THE USE OR OTHER 
 * DEALINGS IN THE SOFTWARE.
 */

#ifndef Z180_H
#define Z180_H
#include <stdint.h>

// Definitions from https://github.com/wwarthen/RomWBW/blob/master/Source/HBIOS/z180.inc
#define Z180_CNTLA0     0x00        // ASCI0 CONTROL A
#define Z180_CNTLA1     0x01        // ASCI1 CONTROL A
#define Z180_CNTLB0     0x02        // ASCI0 CONTROL B
#define Z180_CNTLB1     0x03        // ASCI1 CONTROL B
#define Z180_STAT0      0x04        // ASCI0 STATUS
#define Z180_STAT1      0x05        // ASCI1 STATUS
#define Z180_TDR0       0x06        // ASCI0 TRANSMIT
#define Z180_TDR1       0x07        // ASCI1 TRANSMIT
#define Z180_RDR0       0x08        // ASCI0 RECEIVE
#define Z180_RDR1       0x09        // ASCI1 RECEIVE
#define Z180_CNTR       0x0A        // CSI/O CONTROL
#define Z180_TRDR       0x0B        // CSI/O TRANSMIT/RECEIVE
#define Z180_TMDR0L     0x0C        // TIMER 0 DATA LO
#define Z180_TMDR0H     0x0D        // TIMER 0 DATA HI
#define Z180_RLDR0L     0x0E        // TIMER 0 RELOAD LO
#define Z180_RLDR0H     0x0F        // TIMER 0 RELOAD HI
#define Z180_TCR        0x10        // TIMER CONTROL
#define Z180_ASEXT0     0x12        // ASCI0 EXTENSION CONTROL (Z8S180)
#define Z180_ASEXT1     0x13        // ASCI1 EXTENSION CONTROL (Z8S180)
#define Z180_TMDR1L     0x14        // TIMER 1 DATA LO
#define Z180_TMDR1H     0x15        // TIMER 1 DATA HI
#define Z180_RLDR1L     0x16        // TIMER 1 RELOAD LO
#define Z180_RLDR1H     0x17        // TIMER 1 RELOAD HI
#define Z180_FRC        0x18        // FREE RUNNING COUNTER
#define Z180_ASTC0L     0x1A        // ASCI0 TIME CONSTANT LO (Z8S180)
#define Z180_ASTC0H     0x1B        // ASCI0 TIME CONSTANT HI (Z8S180)
#define Z180_ASTC1L     0x1C        // ASCI1 TIME CONSTANT LO (Z8S180)
#define Z180_ASTC1H     0x1D        // ASCI1 TIME CONSTANT HI (Z8S180)
#define Z180_CMR        0x1E        // CLOCK MULTIPLIER (LATEST Z8S180)
#define Z180_CCR        0x1F        // CPU CONTROL (Z8S180)
#define Z180_SAR0L      0x20        // DMA0 SOURCE ADDR LO
#define Z180_SAR0H      0x21        // DMA0 SOURCE ADDR HI
#define Z180_SAR0B      0x22        // DMA0 SOURCE ADDR BANK
#define Z180_DAR0L      0x23        // DMA0 DEST ADDR LO
#define Z180_DAR0H      0x24        // DMA0 DEST ADDR HI
#define Z180_DAR0B      0x25        // DMA0 DEST ADDR BANK
#define Z180_BCR0L      0x26        // DMA0 BYTE COUNT LO
#define Z180_BCR0H      0x27        // DMA0 BYTE COUNT HI
#define Z180_MAR1L      0x28        // DMA1 MEMORY ADDR LO
#define Z180_MAR1H      0x29        // DMA1 MEMORY ADDR HI
#define Z180_MAR1B      0x2A        // DMA1 MEMORY ADDR BANK
#define Z180_IAR1L      0x2B        // DMA1 I/O ADDR LO
#define Z180_IAR1H      0x2C        // DMA1 I/O ADDR HI
#define Z180_IAR1B      0x2D        // DMA1 I/O ADDR BANK (Z8S180)
#define Z180_BCR1L      0x2E        // DMA1 BYTE COUNT LO
#define Z180_BCR1H      0x2F        // DMA1 BYTE COUNT HI
#define Z180_DSTAT      0x30        // DMA STATUS
#define Z180_DMODE      0x31        // DMA MODE
#define Z180_DCNTL      0x32        // DMA/WAIT CONTROL
#define Z180_IL         0x33        // INTERRUPT VECTOR LOAD
#define Z180_ITC        0x34        // INT/TRAP CONTROL
#define Z180_RCR        0x36        // 0xREFRES CONTROL
#define Z180_CBR        0x38        // MMU COMMON BASE REGISTER
#define Z180_BBR        0x39        // MMU BANK BASE REGISTER
#define Z180_CBAR       0x3A        // MMU COMMON/BANK AREA REGISTER
#define Z180_OMCR       0x3E        // OPERATION MODE CONTROL
#define Z180_ICR        0x3F        // I/O CONTROL REGISTER

extern uint8_t Z180Detect();
extern uint8_t Z180Read(uint8_t register);
extern void Z180Write(uint8_t register, uint8_t value);
extern uint8_t Z180GetClock();
extern void Z180ClockSlow();
extern void Z180ClockNormal();
extern void Z180ClockFast();
extern void Z180SetIOWait(uint8_t waits);
extern void Z180SetMemWait(uint8_t waits);

#endif