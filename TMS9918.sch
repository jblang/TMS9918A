EESchema Schematic File Version 4
LIBS:TMS9918-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "TMS9918A video card for RC2014"
Date "2018-10-25"
Rev "REV4"
Comp "J.B. Langston"
Comment1 "https://github.com/jblang/rc9918"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x39 J1
U 1 1 5A772849
P 750 2800
F 0 "J1" H 750 4800 50  0000 C CNN
F 1 "Conn_01x39" H 750 800 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x39_P2.54mm_Vertical" H 750 2800 50  0001 C CNN
F 3 "" H 750 2800 50  0001 C CNN
	1    750  2800
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74LS574 U5
U 1 1 5A7779C0
P 6100 5250
F 0 "U5" H 6100 5250 50  0000 C CNN
F 1 "74HCT574" H 6150 4900 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 6100 5250 50  0001 C CNN
F 3 "" H 6100 5250 50  0001 C CNN
	1    6100 5250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS574 U6
U 1 1 5A777A33
P 8000 5250
F 0 "U6" H 8000 5250 50  0000 C CNN
F 1 "74HCT574" H 8050 4900 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 8000 5250 50  0001 C CNN
F 3 "" H 8000 5250 50  0001 C CNN
	1    8000 5250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS574 U7
U 1 1 5A777AC8
P 9950 5250
F 0 "U7" H 9950 5250 50  0000 C CNN
F 1 "74HCT574" H 10000 4900 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 9950 5250 50  0001 C CNN
F 3 "" H 9950 5250 50  0001 C CNN
	1    9950 5250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U4
U 2 1 5A777B56
P 6000 2550
F 0 "U4" H 6150 2650 50  0000 C CNN
F 1 "74HCT04" H 6200 2450 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6000 2550 50  0001 C CNN
F 3 "" H 6000 2550 50  0001 C CNN
	2    6000 2550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U4
U 3 1 5A777CB6
P 6000 2950
F 0 "U4" H 6150 3050 50  0000 C CNN
F 1 "74HCT04" H 6200 2850 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6000 2950 50  0001 C CNN
F 3 "" H 6000 2950 50  0001 C CNN
	3    6000 2950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U4
U 4 1 5A777D02
P 6000 1600
F 0 "U4" H 6150 1700 50  0000 C CNN
F 1 "74HCT04" H 6200 1500 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6000 1600 50  0001 C CNN
F 3 "" H 6000 1600 50  0001 C CNN
	4    6000 1600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U4
U 5 1 5A778370
P 6000 1000
F 0 "U4" H 6150 1100 50  0000 C CNN
F 1 "74HCT04" H 6200 900 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6000 1000 50  0001 C CNN
F 3 "" H 6000 1000 50  0001 C CNN
	5    6000 1000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U4
U 1 1 5A77837C
P 6000 2150
F 0 "U4" H 6150 2250 50  0000 C CNN
F 1 "74HCT04" H 6200 2050 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6000 2150 50  0001 C CNN
F 3 "" H 6000 2150 50  0001 C CNN
	1    6000 2150
	1    0    0    -1  
$EndComp
Text Label 4700 1250 0    60   ~ 0
AD0
Text Label 4700 1350 0    60   ~ 0
AD1
Text Label 4700 1450 0    60   ~ 0
AD2
Text Label 4700 1550 0    60   ~ 0
AD3
Text Label 4700 1650 0    60   ~ 0
AD4
Text Label 4700 1750 0    60   ~ 0
AD5
Text Label 4700 1850 0    60   ~ 0
AD6
Text Label 4700 1950 0    60   ~ 0
AD7
Text Label 9300 4750 0    60   ~ 0
AD0
Text Label 9300 4850 0    60   ~ 0
AD1
Text Label 9300 4950 0    60   ~ 0
AD2
Text Label 9300 5050 0    60   ~ 0
AD3
Text Label 9300 5150 0    60   ~ 0
AD4
Text Label 9300 5250 0    60   ~ 0
AD5
Text Label 9300 5350 0    60   ~ 0
AD6
Text Label 9300 5450 0    60   ~ 0
AD7
Text Label 4700 2150 0    60   ~ 0
~RAS~
Text Label 4700 2250 0    60   ~ 0
~CAS~
$Comp
L power:GND #PWR01
U 1 1 5A77A6A2
P 8000 6100
F 0 "#PWR01" H 8000 5850 50  0001 C CNN
F 1 "GND" H 8000 5950 50  0000 C CNN
F 2 "" H 8000 6100 50  0001 C CNN
F 3 "" H 8000 6100 50  0001 C CNN
	1    8000 6100
	1    0    0    -1  
$EndComp
Text Label 5450 5650 0    60   ~ 0
~R~W
$Comp
L TMS9918-rescue:HM62256BLP-7-TMS9918 U8
U 1 1 5A77A9F9
P 9000 2350
F 0 "U8" H 8700 3250 50  0000 C CNN
F 1 "HM62256BLP-7" H 9400 1550 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket" H 9000 2350 50  0001 C CIN
F 3 "" H 9000 2350 50  0001 C CNN
	1    9000 2350
	1    0    0    -1  
$EndComp
NoConn ~ 8500 4750
NoConn ~ 10450 4750
Text Label 6750 4750 2    60   ~ 0
VD0
Text Label 6750 4850 2    60   ~ 0
VD1
Text Label 6750 4950 2    60   ~ 0
VD2
Text Label 6750 5050 2    60   ~ 0
VD3
Text Label 6750 5150 2    60   ~ 0
VD4
Text Label 6750 5250 2    60   ~ 0
VD5
Text Label 6750 5350 2    60   ~ 0
VD6
Text Label 6750 5450 2    60   ~ 0
VD7
$Comp
L power:VCC #PWR03
U 1 1 5A782469
P 3950 900
F 0 "#PWR03" H 3950 750 50  0001 C CNN
F 1 "VCC" H 3950 1050 50  0000 C CNN
F 2 "" H 3950 900 50  0001 C CNN
F 3 "" H 3950 900 50  0001 C CNN
	1    3950 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5A782608
P 3950 4150
F 0 "#PWR04" H 3950 3900 50  0001 C CNN
F 1 "GND" H 3950 4000 50  0000 C CNN
F 2 "" H 3950 4150 50  0001 C CNN
F 3 "" H 3950 4150 50  0001 C CNN
	1    3950 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5A782922
P 2500 3900
F 0 "C1" H 2400 4000 50  0000 L CNN
F 1 "16pf" H 2525 3800 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 2538 3750 50  0001 C CNN
F 3 "" H 2500 3900 50  0001 C CNN
	1    2500 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5A782C60
P 3100 3900
F 0 "C2" H 3125 4000 50  0000 L CNN
F 1 "16pf" H 3125 3800 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 3138 3750 50  0001 C CNN
F 3 "" H 3100 3900 50  0001 C CNN
	1    3100 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5A782C91
P 3700 5300
F 0 "C3" H 3725 5400 50  0000 L CNN
F 1 "0.1uf" H 3725 5200 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 3738 5150 50  0001 C CNN
F 3 "" H 3700 5300 50  0001 C CNN
	1    3700 5300
	-1   0    0    -1  
$EndComp
$Comp
L Device:Q_NPN_EBC Q1
U 1 1 5A782EC0
P 4550 5350
F 0 "Q1" H 4750 5400 50  0000 L CNN
F 1 "2N4401" H 4750 5300 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92" H 4750 5450 50  0001 C CNN
F 3 "" H 4550 5350 50  0001 C CNN
	1    4550 5350
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5A782FE1
P 4800 4800
F 0 "R2" V 4880 4800 50  0000 C CNN
F 1 "0" V 4800 4800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4730 4800 50  0001 C CNN
F 3 "" H 4800 4800 50  0001 C CNN
	1    4800 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5A783262
P 4800 5950
F 0 "R3" V 4880 5950 50  0000 C CNN
F 1 "470" V 4800 5950 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4730 5950 50  0001 C CNN
F 3 "" H 4800 5950 50  0001 C CNN
	1    4800 5950
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5A783339
P 4450 5950
F 0 "R1" V 4530 5950 50  0000 C CNN
F 1 "75" V 4450 5950 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4380 5950 50  0001 C CNN
F 3 "" H 4450 5950 50  0001 C CNN
	1    4450 5950
	-1   0    0    -1  
$EndComp
$Comp
L Device:Ferrite_Bead L1
U 1 1 5A7833DE
P 3700 4800
F 0 "L1" V 3550 4825 50  0000 C CNN
F 1 "Ferrite_Bead" V 3850 4800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3630 4800 50  0001 C CNN
F 3 "" H 3700 4800 50  0001 C CNN
	1    3700 4800
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J2
U 1 1 5A78351D
P 4150 5700
F 0 "J2" H 4160 5820 50  0000 C CNN
F 1 "Conn_Coaxial" V 4265 5700 50  0000 C CNN
F 2 "w_conn_av:KLPX-0848A" H 4150 5700 50  0001 C CNN
F 3 "" H 4150 5700 50  0001 C CNN
	1    4150 5700
	-1   0    0    -1  
$EndComp
$Comp
L Device:Crystal Y1
U 1 1 5A7835AA
P 2800 3650
F 0 "Y1" H 2800 3800 50  0000 C CNN
F 1 "10.738635MHz" H 2800 3500 50  0000 C CNN
F 2 "Crystal:Crystal_HC49-4H_Vertical" H 2800 3650 50  0001 C CNN
F 3 "" H 2800 3650 50  0001 C CNN
	1    2800 3650
	1    0    0    -1  
$EndComp
$Comp
L TMS9918-rescue:TMS9918A-TMS9918 U3
U 1 1 5A78610F
P 3950 2450
F 0 "U3" H 3450 3850 60  0000 C CNN
F 1 "TMS9918A" H 4300 1050 60  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_Socket" H 4000 2550 60  0001 C CNN
F 3 "" H 4000 2550 60  0001 C CNN
	1    3950 2450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR05
U 1 1 5A786C7D
P 3700 4550
F 0 "#PWR05" H 3700 4400 50  0001 C CNN
F 1 "VCC" H 3700 4700 50  0000 C CNN
F 2 "" H 3700 4550 50  0001 C CNN
F 3 "" H 3700 4550 50  0001 C CNN
	1    3700 4550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5A78728F
P 4150 6150
F 0 "#PWR06" H 4150 5900 50  0001 C CNN
F 1 "GND" H 4150 6000 50  0000 C CNN
F 2 "" H 4150 6150 50  0001 C CNN
F 3 "" H 4150 6150 50  0001 C CNN
	1    4150 6150
	-1   0    0    -1  
$EndComp
Text Label 9700 1600 2    60   ~ 0
VD0
Text Label 9700 1700 2    60   ~ 0
VD1
Text Label 9700 1800 2    60   ~ 0
VD2
Text Label 9700 1900 2    60   ~ 0
VD3
Text Label 9700 2000 2    60   ~ 0
VD4
Text Label 9700 2100 2    60   ~ 0
VD5
Text Label 9700 2200 2    60   ~ 0
VD6
Text Label 9700 2300 2    60   ~ 0
VD7
Text Label 9700 2550 2    60   ~ 0
R~W~
Text Label 9700 2450 2    60   ~ 0
~R~W
Text Label 9700 2700 2    60   ~ 0
~CAS~
Text Label 4700 2350 0    60   ~ 0
R~W~
$Comp
L Device:C C4
U 1 1 5A79986C
P 10900 5300
F 0 "C4" H 10925 5400 50  0000 L CNN
F 1 "0.1uf" H 10925 5200 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 10938 5150 50  0001 C CNN
F 3 "" H 10900 5300 50  0001 C CNN
	1    10900 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5A799A39
P 8900 5300
F 0 "C5" H 8925 5400 50  0000 L CNN
F 1 "0.1uf" H 8925 5200 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 8938 5150 50  0001 C CNN
F 3 "" H 8900 5300 50  0001 C CNN
	1    8900 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5A799A9F
P 8000 2350
F 0 "C6" H 8025 2450 50  0000 L CNN
F 1 "0.1uf" H 8025 2250 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 8038 2200 50  0001 C CNN
F 3 "" H 8000 2350 50  0001 C CNN
	1    8000 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 5A799B12
P 5100 2350
F 0 "C7" H 5125 2450 50  0000 L CNN
F 1 "0.1uf" H 5125 2250 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5138 2200 50  0001 C CNN
F 3 "" H 5100 2350 50  0001 C CNN
	1    5100 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5A799B88
P 7000 5300
F 0 "C8" H 7025 5400 50  0000 L CNN
F 1 "0.1uf" H 7025 5200 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 7038 5150 50  0001 C CNN
F 3 "" H 7000 5300 50  0001 C CNN
	1    7000 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5A799BEF
P 1000 6850
F 0 "C9" H 1025 6950 50  0000 L CNN
F 1 "0.1uf" H 1025 6750 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 1038 6700 50  0001 C CNN
F 3 "" H 1000 6850 50  0001 C CNN
	1    1000 6850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5A79A0B1
P 5850 6500
F 0 "#PWR07" H 5850 6350 50  0001 C CNN
F 1 "VCC" H 5850 6650 50  0000 C CNN
F 2 "" H 5850 6500 50  0001 C CNN
F 3 "" H 5850 6500 50  0001 C CNN
	1    5850 6500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5A79A0FD
P 5850 7600
F 0 "#PWR08" H 5850 7350 50  0001 C CNN
F 1 "GND" H 5850 7450 50  0000 C CNN
F 2 "" H 5850 7600 50  0001 C CNN
F 3 "" H 5850 7600 50  0001 C CNN
	1    5850 7600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 5A79AE12
P 7450 2350
F 0 "C10" H 7475 2450 50  0000 L CNN
F 1 "0.1uf" H 7475 2250 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 7488 2200 50  0001 C CNN
F 3 "" H 7450 2350 50  0001 C CNN
	1    7450 2350
	1    0    0    -1  
$EndComp
Text Label 3200 1950 2    60   ~ 0
D0
Text Label 3200 1850 2    60   ~ 0
D1
Text Label 3200 1750 2    60   ~ 0
D2
Text Label 3200 1650 2    60   ~ 0
D3
Text Label 3200 1550 2    60   ~ 0
D4
Text Label 3200 1450 2    60   ~ 0
D5
Text Label 3200 1350 2    60   ~ 0
D6
Text Label 3200 1250 2    60   ~ 0
D7
Text Label 950  2100 0    60   ~ 0
D0
Text Label 950  2000 0    60   ~ 0
D1
Text Label 950  1900 0    60   ~ 0
D2
Text Label 950  1800 0    60   ~ 0
D3
Text Label 950  1700 0    60   ~ 0
D4
Text Label 950  1600 0    60   ~ 0
D5
Text Label 950  1500 0    60   ~ 0
D6
Text Label 950  1400 0    60   ~ 0
D7
Text Label 4700 2550 0    60   ~ 0
VD0
Text Label 4700 2650 0    60   ~ 0
VD1
Text Label 4700 2750 0    60   ~ 0
VD2
Text Label 4700 2850 0    60   ~ 0
VD3
Text Label 4700 2950 0    60   ~ 0
VD4
Text Label 4700 3050 0    60   ~ 0
VD5
Text Label 4700 3150 0    60   ~ 0
VD6
Text Label 4700 3250 0    60   ~ 0
VD7
Text Label 8650 4850 2    60   ~ 0
VA0
Text Label 8650 4950 2    60   ~ 0
VA1
Text Label 8650 5050 2    60   ~ 0
VA2
Text Label 8650 5150 2    60   ~ 0
VA3
Text Label 8650 5250 2    60   ~ 0
VA4
Text Label 8650 5350 2    60   ~ 0
VA5
Text Label 8650 5450 2    60   ~ 0
VA6
Text Label 10650 4850 2    60   ~ 0
VA7
Text Label 10650 4950 2    60   ~ 0
VA8
Text Label 10650 5050 2    60   ~ 0
VA9
Text Label 10650 5150 2    60   ~ 0
VA10
Text Label 10650 5250 2    60   ~ 0
VA11
Text Label 10650 5350 2    60   ~ 0
VA12
Text Label 10650 5450 2    60   ~ 0
VA13
$Comp
L power:GND #PWR09
U 1 1 5A79E376
P 1250 3100
F 0 "#PWR09" H 1250 2850 50  0001 C CNN
F 1 "GND" H 1250 2950 50  0000 C CNN
F 2 "" H 1250 3100 50  0001 C CNN
F 3 "" H 1250 3100 50  0001 C CNN
	1    1250 3100
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR010
U 1 1 5A79E6FF
P 1250 3000
F 0 "#PWR010" H 1250 2850 50  0001 C CNN
F 1 "VCC" H 1250 3150 50  0000 C CNN
F 2 "" H 1250 3000 50  0001 C CNN
F 3 "" H 1250 3000 50  0001 C CNN
	1    1250 3000
	-1   0    0    -1  
$EndComp
NoConn ~ 950  900 
NoConn ~ 950  1000
NoConn ~ 950  1100
NoConn ~ 950  1200
NoConn ~ 950  1300
NoConn ~ 950  2500
NoConn ~ 950  2900
NoConn ~ 950  4700
NoConn ~ 950  4600
NoConn ~ 950  4500
NoConn ~ 950  4400
NoConn ~ 950  4300
Text Label 950  3200 0    60   ~ 0
A0
Text Label 950  3600 0    60   ~ 0
A4
Text Label 950  3700 0    60   ~ 0
A5
Text Label 950  3800 0    60   ~ 0
A6
Text Label 950  3900 0    60   ~ 0
A7
Text Label 950  2800 0    60   ~ 0
~RESET~
Text Label 950  2600 0    60   ~ 0
~INT~
Text Label 950  2300 0    60   ~ 0
~RD~
Text Label 950  2200 0    60   ~ 0
~IORQ~
Text Label 7350 5650 0    60   ~ 0
ROW
Text Label 9300 5650 0    60   ~ 0
COL
Text Label 3200 2250 2    60   ~ 0
~CSW~
Text Label 3200 2350 2    60   ~ 0
~CSR~
$Comp
L 74xx:74HCT04 U4
U 6 1 5A7A42CA
P 1900 5700
F 0 "U4" H 2050 5800 50  0000 C CNN
F 1 "74HCT04" H 2100 5600 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 1900 5700 50  0001 C CNN
F 3 "" H 1900 5700 50  0001 C CNN
	6    1900 5700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U1
U 1 1 5A7CFD14
P 1800 4400
F 0 "U1" H 1800 4450 50  0000 C CNN
F 1 "74HCT32" H 1800 4350 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 1800 4400 50  0001 C CNN
F 3 "" H 1800 4400 50  0001 C CNN
	1    1800 4400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U1
U 3 1 5A7CFDCF
P 4850 6800
F 0 "U1" H 4850 6850 50  0000 C CNN
F 1 "74HCT32" H 4850 6750 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4850 6800 50  0001 C CNN
F 3 "" H 4850 6800 50  0001 C CNN
	3    4850 6800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U1
U 2 1 5A7CFEC8
P 4850 7300
F 0 "U1" H 4850 7350 50  0000 C CNN
F 1 "74HCT32" H 4850 7250 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4850 7300 50  0001 C CNN
F 3 "" H 4850 7300 50  0001 C CNN
	2    4850 7300
	1    0    0    -1  
$EndComp
NoConn ~ 950  4200
NoConn ~ 950  4100
NoConn ~ 950  4000
Text Label 950  2400 0    60   ~ 0
~WR~
Text Label 950  3300 0    60   ~ 0
A1
Text Label 950  3400 0    60   ~ 0
A2
Text Label 950  3500 0    60   ~ 0
A3
Text Label 3350 6850 2    60   ~ 0
~ADDR~
$Comp
L Device:C C11
U 1 1 5A7DB855
P 6250 7050
F 0 "C11" H 6275 7150 50  0000 L CNN
F 1 "0.1uf" H 6275 6950 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6288 6900 50  0001 C CNN
F 3 "" H 6250 7050 50  0001 C CNN
	1    6250 7050
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x14 J3
U 1 1 5B0E0805
P 10650 2350
F 0 "J3" H 10650 3050 50  0000 C CNN
F 1 "Conn_01x14" H 10650 1550 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x14_P2.54mm_Vertical" H 10650 2350 50  0001 C CNN
F 3 "" H 10650 2350 50  0001 C CNN
	1    10650 2350
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR011
U 1 1 5B0E4F37
P 10050 3050
F 0 "#PWR011" H 10050 2900 50  0001 C CNN
F 1 "VCC" H 10050 3200 50  0000 C CNN
F 2 "" H 10050 3050 50  0001 C CNN
F 3 "" H 10050 3050 50  0001 C CNN
	1    10050 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3650 4700 3650
Wire Wire Line
	4800 4650 4800 3650
Connection ~ 4800 5350
Wire Wire Line
	4800 5350 4750 5350
Wire Wire Line
	4800 4950 4800 5350
Connection ~ 4450 6100
Connection ~ 4150 6100
Wire Wire Line
	3700 6100 3700 5450
Connection ~ 3700 5100
Wire Wire Line
	3700 4950 3700 5100
Wire Wire Line
	4450 5100 3700 5100
Wire Wire Line
	4450 5150 4450 5100
Wire Wire Line
	4150 5900 4150 6100
Wire Wire Line
	3700 6100 4150 6100
Connection ~ 4450 5700
Wire Wire Line
	4450 5700 4350 5700
Wire Wire Line
	4450 5550 4450 5700
Wire Wire Line
	3700 4550 3700 4650
Connection ~ 3950 4050
Connection ~ 3100 4050
Wire Wire Line
	2500 4050 3100 4050
Connection ~ 2500 3650
Wire Wire Line
	2500 3250 3200 3250
Wire Wire Line
	2500 3250 2500 3650
Wire Wire Line
	2650 3650 2500 3650
Connection ~ 3100 3650
Wire Wire Line
	3100 3750 3100 3650
Wire Wire Line
	2950 3650 3100 3650
Wire Wire Line
	3950 3950 3950 4050
Wire Wire Line
	3950 950  3950 900 
Wire Wire Line
	6750 5450 6600 5450
Wire Wire Line
	6750 5350 6600 5350
Wire Wire Line
	6750 5250 6600 5250
Wire Wire Line
	6750 5150 6600 5150
Wire Wire Line
	6750 5050 6600 5050
Wire Wire Line
	6750 4950 6600 4950
Wire Wire Line
	6750 4850 6600 4850
Wire Wire Line
	6750 4750 6600 4750
Wire Wire Line
	950  3000 1250 3000
Wire Wire Line
	10050 3050 10450 3050
Text Label 10450 1750 2    60   ~ 0
VD3
Text Label 10450 1850 2    60   ~ 0
VD4
Text Label 10450 1950 2    60   ~ 0
VD5
Text Label 10450 2050 2    60   ~ 0
VD6
Text Label 10450 2150 2    60   ~ 0
VD7
Text Label 10450 2250 2    60   ~ 0
~CAS~
Text Label 10450 2350 2    60   ~ 0
VA4
Text Label 10450 2450 2    60   ~ 0
~R~W
Text Label 10450 2550 2    60   ~ 0
VA7
Text Label 10450 2650 2    60   ~ 0
VA10
Text Label 10450 2750 2    60   ~ 0
VA12
Text Label 10450 2850 2    60   ~ 0
VA13
Text Label 10450 2950 2    60   ~ 0
R~W~
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J4
U 1 1 5B1E36E0
P 2700 6850
F 0 "J4" H 2750 7250 50  0000 C CNN
F 1 "Conn_02x08_Odd_Even" H 2750 6350 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x08_P2.54mm_Vertical" H 2700 6850 50  0001 C CNN
F 3 "" H 2700 6850 50  0001 C CNN
	1    2700 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 6550 2500 6550
Wire Wire Line
	2450 6650 2500 6650
Wire Wire Line
	2450 6750 2500 6750
Wire Wire Line
	2450 6850 2500 6850
Wire Wire Line
	2450 6950 2500 6950
Wire Wire Line
	2450 7050 2500 7050
Wire Wire Line
	2450 7150 2500 7150
Wire Wire Line
	2450 7250 2500 7250
Wire Wire Line
	3050 7250 3000 7250
Wire Wire Line
	3050 6550 3000 6550
Wire Wire Line
	3050 6650 3000 6650
Connection ~ 3050 6650
Wire Wire Line
	3050 6750 3000 6750
Connection ~ 3050 6750
Wire Wire Line
	3000 6850 3050 6850
Connection ~ 3050 6850
Wire Wire Line
	3000 6950 3050 6950
Connection ~ 3050 6950
Wire Wire Line
	3050 7050 3000 7050
Connection ~ 3050 7050
Wire Wire Line
	3000 7150 3050 7150
Connection ~ 3050 7150
Text Label 1450 6750 2    60   ~ 0
A7
Text Label 1450 6650 2    60   ~ 0
A6
Text Label 1450 7050 2    60   ~ 0
E3
Text Label 1450 7150 2    60   ~ 0
~E2~
Text Label 1450 6550 2    60   ~ 0
A5
Text Label 1450 7250 2    60   ~ 0
~E1~
$Comp
L 74xx:74LS32 U1
U 4 1 5A7CFBC7
P 3650 6950
F 0 "U1" H 3650 7000 50  0000 C CNN
F 1 "74HCT32" H 3650 6900 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 3650 6950 50  0001 C CNN
F 3 "" H 3650 6950 50  0001 C CNN
	4    3650 6950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS138 U2
U 1 1 5B25AE81
P 1950 6850
F 0 "U2" H 2050 7350 50  0000 C CNN
F 1 "74LS138" H 2100 6301 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 1950 6850 50  0001 C CNN
F 3 "" H 1950 6850 50  0001 C CNN
	1    1950 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4650 2600 4650
Text Label 2600 4650 2    60   ~ 0
~E1~
Text Label 1500 4300 2    60   ~ 0
A1
Text Label 1500 4500 2    60   ~ 0
A2
Text Label 1500 4950 2    60   ~ 0
A3
$Comp
L Device:Jumper_NC_Dual JP1
U 1 1 5B4BE5F8
P 2400 4400
F 0 "JP1" H 2450 4300 50  0000 L CNN
F 1 "A1/A2" H 2400 4500 50  0000 C BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2400 4400 50  0001 C CNN
F 3 "" H 2400 4400 50  0001 C CNN
	1    2400 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 4400 2150 4400
Wire Wire Line
	2400 4500 2400 4650
Wire Wire Line
	2400 5200 2600 5200
Text Label 3100 5600 2    60   ~ 0
~E2~
$Comp
L Device:Jumper_NC_Dual JP2
U 1 1 5B4BEF99
P 2400 4950
F 0 "JP2" H 2450 4850 50  0000 L CNN
F 1 "A3" H 2400 5050 50  0000 C BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2400 4950 50  0001 C CNN
F 3 "" H 2400 4950 50  0001 C CNN
	1    2400 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 5050 2400 5200
Text Label 2600 5200 2    60   ~ 0
E3
$Comp
L power:GND #PWR012
U 1 1 5B4BF4D4
P 2800 4400
F 0 "#PWR012" H 2800 4150 50  0001 C CNN
F 1 "GND" H 2800 4250 50  0000 C CNN
F 2 "" H 2800 4400 50  0001 C CNN
F 3 "" H 2800 4400 50  0001 C CNN
	1    2800 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5B4BF557
P 2350 5250
F 0 "#PWR013" H 2350 5000 50  0001 C CNN
F 1 "GND" H 2350 5100 50  0000 C CNN
F 2 "" H 2350 5250 50  0001 C CNN
F 3 "" H 2350 5250 50  0001 C CNN
	1    2350 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4400 2800 4400
Wire Wire Line
	2650 4950 2800 4950
$Comp
L power:VCC #PWR014
U 1 1 5B4BF9CF
P 2800 4950
F 0 "#PWR014" H 2800 4800 50  0001 C CNN
F 1 "VCC" H 2800 5100 50  0000 C CNN
F 2 "" H 2800 4950 50  0001 C CNN
F 3 "" H 2800 4950 50  0001 C CNN
	1    2800 4950
	1    0    0    -1  
$EndComp
Text Label 3350 7050 2    60   ~ 0
~IORQ~
Text Label 5150 7300 0    60   ~ 0
~CSW~
Text Label 5150 6800 0    60   ~ 0
~CSR~
Text Label 4550 6700 2    60   ~ 0
~IORQ+ADDR~
Text Label 4550 7400 2    60   ~ 0
~WR~
Wire Wire Line
	3050 6550 3050 6650
Wire Wire Line
	950  3100 1250 3100
Wire Wire Line
	4000 6700 4550 6700
Wire Wire Line
	4000 6700 4000 6950
Wire Wire Line
	4000 7200 4550 7200
Text Label 4550 6900 2    60   ~ 0
~RD~
Text Label 2200 5700 0    60   ~ 0
~A4~
Text Label 3200 2150 2    60   ~ 0
A0
Text Label 3200 2650 2    60   ~ 0
~RESET~
$Comp
L Device:Jumper_NC_Dual JP4
U 1 1 5B4C882E
P 1800 2150
F 0 "JP4" H 1850 2050 50  0000 L CNN
F 1 "Jumper_NC_Dual" H 1800 2250 50  0000 C BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 1800 2150 50  0001 C CNN
F 3 "" H 1800 2150 50  0001 C CNN
	1    1800 2150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2050 2550 2050 2150
Wire Wire Line
	2050 2150 1900 2150
Wire Wire Line
	1800 1900 1800 1650
Wire Wire Line
	1800 2400 1800 2600
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J6
U 1 1 5B562712
P 2650 5600
F 0 "J6" H 2700 5800 50  0000 C CNN
F 1 "A4" H 2700 5400 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 2650 5600 50  0001 C CNN
F 3 "" H 2650 5600 50  0001 C CNN
	1    2650 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 5500 2950 5600
Connection ~ 2950 5600
Wire Wire Line
	1600 5700 1550 5700
Wire Wire Line
	2950 5600 3100 5600
Text Label 1500 5700 2    60   ~ 0
A4
Connection ~ 1550 5700
Wire Wire Line
	3950 6950 4000 6950
Connection ~ 4000 6950
Wire Wire Line
	2200 5700 2450 5700
Wire Wire Line
	1550 5700 1550 5500
Wire Wire Line
	2400 5500 2400 5600
Wire Wire Line
	2400 5600 2450 5600
$Comp
L Connector_Generic:Conn_01x05 J7
U 1 1 5B565167
P 5900 3700
F 0 "J7" H 5900 3900 50  0000 C CNN
F 1 "Ext" H 5900 3400 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical" H 5900 3700 50  0001 C CNN
F 3 "" H 5900 3700 50  0001 C CNN
	1    5900 3700
	-1   0    0    -1  
$EndComp
Text Label 3200 2550 2    60   ~ 0
~INTNMI~
Text Label 1800 1650 0    60   ~ 0
~NMI~
Text Label 4700 3450 0    60   ~ 0
EXTVDP
Text Label 6100 3700 0    60   ~ 0
GROMCLK
Text Label 6100 3600 0    60   ~ 0
CPUCLK
Text Label 6100 3800 0    60   ~ 0
EXTVDP
$Comp
L power:GND #PWR015
U 1 1 5B565AEA
P 6250 3900
F 0 "#PWR015" H 6250 3650 50  0001 C CNN
F 1 "GND" H 6250 3750 50  0000 C CNN
F 2 "" H 6250 3900 50  0001 C CNN
F 3 "" H 6250 3900 50  0001 C CNN
	1    6250 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 3900 6250 3900
Text Label 3200 2900 2    60   ~ 0
GROMCLK
Text Label 3200 3000 2    60   ~ 0
CPUCLK
$Comp
L Connector_Generic:Conn_01x10 J5
U 1 1 5B5672B7
P 1600 1150
F 0 "J5" H 1600 1650 50  0000 C CNN
F 1 "Conn_01x10" H 1600 550 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x10_P2.54mm_Vertical" H 1600 1150 50  0001 C CNN
F 3 "" H 1600 1150 50  0001 C CNN
	1    1600 1150
	-1   0    0    -1  
$EndComp
NoConn ~ 1800 1550
NoConn ~ 1800 1450
NoConn ~ 1800 1350
NoConn ~ 1800 1250
NoConn ~ 1800 1150
NoConn ~ 1800 1050
NoConn ~ 1800 950 
$Comp
L power:GND #PWR016
U 1 1 5B567544
P 2300 750
F 0 "#PWR016" H 2300 500 50  0001 C CNN
F 1 "GND" H 2300 600 50  0000 C CNN
F 2 "" H 2300 750 50  0001 C CNN
F 3 "" H 2300 750 50  0001 C CNN
	1    2300 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 750  2300 750 
$Comp
L power:VCC #PWR017
U 1 1 5B5676EA
P 2100 1000
F 0 "#PWR017" H 2100 850 50  0001 C CNN
F 1 "VCC" H 2100 1150 50  0000 C CNN
F 2 "" H 2100 1000 50  0001 C CNN
F 3 "" H 2100 1000 50  0001 C CNN
	1    2100 1000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1800 850  1950 850 
Wire Wire Line
	1950 850  1950 1000
Wire Wire Line
	1950 1000 2100 1000
Text Label 8500 3000 2    60   ~ 0
VA13
Text Label 8500 2900 2    60   ~ 0
VA13
Text Label 8500 2400 2    60   ~ 0
VA12
Text Label 8500 2800 2    60   ~ 0
VA11
Text Label 8500 2500 2    60   ~ 0
VA10
Text Label 8500 2300 2    60   ~ 0
VA9
Text Label 8500 2200 2    60   ~ 0
VA8
Text Label 8500 2700 2    60   ~ 0
VA7
Text Label 8500 1600 2    60   ~ 0
VA0
Text Label 8500 1700 2    60   ~ 0
VA1
Text Label 8500 1800 2    60   ~ 0
VA2
Text Label 8500 1900 2    60   ~ 0
VA3
Text Label 8500 2000 2    60   ~ 0
VA5
Text Label 8500 2100 2    60   ~ 0
VA6
Text Label 8500 2600 2    60   ~ 0
VA4
Wire Wire Line
	2350 5250 2450 5250
Wire Wire Line
	2450 5250 2450 5500
Wire Wire Line
	4800 5350 4800 5800
Wire Wire Line
	4450 6100 4800 6100
Wire Wire Line
	4150 6100 4150 6150
Wire Wire Line
	4150 6100 4450 6100
Wire Wire Line
	3700 5100 3700 5150
Wire Wire Line
	4450 5700 4450 5800
Wire Wire Line
	3950 4050 3950 4150
Wire Wire Line
	3100 4050 3950 4050
Wire Wire Line
	2500 3650 2500 3750
Wire Wire Line
	3100 3650 3200 3650
Wire Wire Line
	3050 6650 3050 6750
Wire Wire Line
	3050 6750 3050 6850
Wire Wire Line
	3050 6850 3350 6850
Wire Wire Line
	3050 6850 3050 6950
Wire Wire Line
	3050 6950 3050 7050
Wire Wire Line
	3050 7050 3050 7150
Wire Wire Line
	3050 7150 3050 7250
Wire Wire Line
	2950 5600 2950 5700
Wire Wire Line
	1550 5700 1500 5700
Wire Wire Line
	4000 6950 4000 7200
Wire Wire Line
	8500 4850 8650 4850
Wire Wire Line
	8500 4950 8650 4950
Wire Wire Line
	8500 5050 8650 5050
Wire Wire Line
	8500 5150 8650 5150
Wire Wire Line
	8500 5250 8650 5250
Wire Wire Line
	8500 5350 8650 5350
Wire Wire Line
	8500 5450 8650 5450
Wire Wire Line
	10450 4850 10650 4850
Wire Wire Line
	10450 4950 10650 4950
Wire Wire Line
	10450 5050 10650 5050
Wire Wire Line
	10450 5150 10650 5150
Wire Wire Line
	10450 5250 10650 5250
Wire Wire Line
	10450 5350 10650 5350
Wire Wire Line
	10450 5450 10650 5450
Wire Wire Line
	9300 4750 9450 4750
Wire Wire Line
	9300 4850 9450 4850
Wire Wire Line
	9300 4950 9450 4950
Wire Wire Line
	9300 5050 9450 5050
Wire Wire Line
	9300 5150 9450 5150
Wire Wire Line
	9300 5250 9450 5250
Wire Wire Line
	9300 5350 9450 5350
Wire Wire Line
	9300 5450 9450 5450
Text Label 7350 4750 0    60   ~ 0
AD0
Text Label 7350 4850 0    60   ~ 0
AD1
Text Label 7350 4950 0    60   ~ 0
AD2
Text Label 7350 5050 0    60   ~ 0
AD3
Text Label 7350 5150 0    60   ~ 0
AD4
Text Label 7350 5250 0    60   ~ 0
AD5
Text Label 7350 5350 0    60   ~ 0
AD6
Text Label 7350 5450 0    60   ~ 0
AD7
Wire Wire Line
	7350 4750 7500 4750
Wire Wire Line
	7350 4850 7500 4850
Wire Wire Line
	7350 4950 7500 4950
Wire Wire Line
	7350 5050 7500 5050
Wire Wire Line
	7350 5150 7500 5150
Wire Wire Line
	7350 5250 7500 5250
Wire Wire Line
	7350 5350 7500 5350
Wire Wire Line
	7350 5450 7500 5450
Text Label 5450 4750 0    60   ~ 0
AD0
Text Label 5450 4850 0    60   ~ 0
AD1
Text Label 5450 4950 0    60   ~ 0
AD2
Text Label 5450 5050 0    60   ~ 0
AD3
Text Label 5450 5150 0    60   ~ 0
AD4
Text Label 5450 5250 0    60   ~ 0
AD5
Text Label 5450 5350 0    60   ~ 0
AD6
Text Label 5450 5450 0    60   ~ 0
AD7
Wire Wire Line
	5450 4750 5600 4750
Wire Wire Line
	5450 4850 5600 4850
Wire Wire Line
	5450 4950 5600 4950
Wire Wire Line
	5450 5050 5600 5050
Wire Wire Line
	5450 5150 5600 5150
Wire Wire Line
	5450 5250 5600 5250
Wire Wire Line
	5450 5350 5600 5350
Wire Wire Line
	5450 5450 5600 5450
Text Label 5450 5750 0    60   ~ 0
R~W~
Wire Wire Line
	5450 5750 5600 5750
Text Label 5500 1600 0    60   ~ 0
~RAS~
Wire Wire Line
	5500 1600 5700 1600
Wire Wire Line
	6300 2150 6400 2150
Wire Wire Line
	6400 2150 6400 2350
Wire Wire Line
	6400 2350 5700 2350
Wire Wire Line
	5700 2350 5700 2550
Wire Wire Line
	6300 2550 6400 2550
Wire Wire Line
	6400 2550 6400 2750
Wire Wire Line
	6400 2750 5700 2750
Wire Wire Line
	5700 2750 5700 2950
Text Label 5500 2150 0    60   ~ 0
~CAS~
Wire Wire Line
	5500 2150 5700 2150
Text Label 5500 1000 0    60   ~ 0
R~W~
Wire Wire Line
	5500 1000 5700 1000
Wire Wire Line
	9500 1600 9700 1600
Wire Wire Line
	9500 1700 9700 1700
Wire Wire Line
	9500 1800 9700 1800
Wire Wire Line
	9500 1900 9700 1900
Wire Wire Line
	9500 2000 9700 2000
Wire Wire Line
	9500 2100 9700 2100
Wire Wire Line
	9500 2200 9700 2200
Wire Wire Line
	9500 2300 9700 2300
Wire Wire Line
	9500 2450 9700 2450
Wire Wire Line
	9500 2550 9700 2550
Wire Wire Line
	9500 2700 9700 2700
Text Label 6500 2950 2    60   ~ 0
COL
Wire Wire Line
	6300 2950 6500 2950
Text Label 6500 1000 2    60   ~ 0
~R~W
Wire Wire Line
	6300 1000 6500 1000
Text Label 6500 1600 2    60   ~ 0
ROW
Wire Wire Line
	6300 1600 6500 1600
Wire Wire Line
	9000 1450 9000 1350
Wire Wire Line
	9000 1350 8000 1350
Wire Wire Line
	8000 1350 8000 2200
Wire Wire Line
	8000 2500 8000 3250
Wire Wire Line
	8000 3250 9000 3250
Wire Wire Line
	9000 3250 9000 3150
$Comp
L power:VCC #PWR0101
U 1 1 5C4FB701
P 9000 1350
F 0 "#PWR0101" H 9000 1200 50  0001 C CNN
F 1 "VCC" H 9000 1500 50  0000 C CNN
F 2 "" H 9000 1350 50  0001 C CNN
F 3 "" H 9000 1350 50  0001 C CNN
	1    9000 1350
	1    0    0    -1  
$EndComp
Connection ~ 9000 1350
$Comp
L power:GND #PWR0102
U 1 1 5C4FB807
P 9000 3250
F 0 "#PWR0102" H 9000 3000 50  0001 C CNN
F 1 "GND" H 9000 3100 50  0000 C CNN
F 2 "" H 9000 3250 50  0001 C CNN
F 3 "" H 9000 3250 50  0001 C CNN
	1    9000 3250
	1    0    0    -1  
$EndComp
Connection ~ 9000 3250
$Comp
L power:VCC #PWR0103
U 1 1 5C52E464
P 8000 4400
F 0 "#PWR0103" H 8000 4250 50  0001 C CNN
F 1 "VCC" H 8000 4550 50  0000 C CNN
F 2 "" H 8000 4400 50  0001 C CNN
F 3 "" H 8000 4400 50  0001 C CNN
	1    8000 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 4450 8900 4450
Connection ~ 8000 4450
Wire Wire Line
	8000 4450 8000 4400
Wire Wire Line
	9950 4450 10900 4450
Wire Wire Line
	10900 4450 10900 5150
Wire Wire Line
	10900 5450 10900 6050
Wire Wire Line
	10900 6050 9950 6050
Wire Wire Line
	9950 6050 9450 6050
Wire Wire Line
	8900 6050 8900 5450
Connection ~ 9950 6050
Wire Wire Line
	8900 6050 8000 6050
Wire Wire Line
	8000 6050 7500 6050
Wire Wire Line
	7000 6050 7000 5450
Connection ~ 8000 6050
Wire Wire Line
	7000 6050 6100 6050
Wire Wire Line
	8000 6100 8000 6050
Wire Wire Line
	7000 5150 7000 4450
Wire Wire Line
	7000 4450 6100 4450
Wire Wire Line
	8900 5150 8900 4450
Wire Wire Line
	7500 5750 7500 6050
Wire Wire Line
	9450 5750 9450 6050
Wire Wire Line
	9300 5650 9450 5650
Wire Wire Line
	7350 5650 7500 5650
Wire Wire Line
	5450 5650 5600 5650
Wire Wire Line
	1500 4950 2150 4950
Wire Wire Line
	1550 5500 2400 5500
$Comp
L power:VCC #PWR0104
U 1 1 5C6C01BB
P 1950 6200
F 0 "#PWR0104" H 1950 6050 50  0001 C CNN
F 1 "VCC" H 1950 6350 50  0000 C CNN
F 2 "" H 1950 6200 50  0001 C CNN
F 3 "" H 1950 6200 50  0001 C CNN
	1    1950 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5C6C021C
P 1950 7600
F 0 "#PWR0105" H 1950 7350 50  0001 C CNN
F 1 "GND" H 1950 7450 50  0000 C CNN
F 2 "" H 1950 7600 50  0001 C CNN
F 3 "" H 1950 7600 50  0001 C CNN
	1    1950 7600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6200 1950 6250
Wire Wire Line
	1950 6250 1000 6250
Wire Wire Line
	1000 6250 1000 6700
Connection ~ 1950 6250
Wire Wire Line
	1000 7000 1000 7550
Wire Wire Line
	1000 7550 1950 7550
Wire Wire Line
	1950 7600 1950 7550
Connection ~ 1950 7550
Wire Wire Line
	3950 950  5100 950 
Wire Wire Line
	5100 950  5100 2200
Connection ~ 3950 950 
Wire Wire Line
	3950 4050 5100 4050
Wire Wire Line
	5100 4050 5100 2500
$Comp
L 74xx:74HCT04 U4
U 7 1 5C731BC5
P 6950 2350
F 0 "U4" H 7100 2450 50  0000 C CNN
F 1 "74HCT04" H 7150 2250 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 6950 2350 50  0001 C CNN
F 3 "" H 6950 2350 50  0001 C CNN
	7    6950 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 1850 7450 1850
Wire Wire Line
	7450 1850 7450 2200
Wire Wire Line
	6950 2850 7450 2850
Wire Wire Line
	7450 2850 7450 2500
Connection ~ 4350 5700
Wire Wire Line
	4350 5700 4300 5700
$Comp
L 74xx:74LS32 U1
U 5 1 5C834AD3
P 5850 7050
F 0 "U1" H 5850 7100 50  0000 C CNN
F 1 "74HCT32" H 5850 7000 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5850 7050 50  0001 C CNN
F 3 "" H 5850 7050 50  0001 C CNN
	5    5850 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 6550 5850 6500
Wire Wire Line
	5850 6550 6250 6550
Wire Wire Line
	6250 6550 6250 6900
Connection ~ 5850 6550
Wire Wire Line
	6250 7200 6250 7550
Wire Wire Line
	6250 7550 5850 7550
Wire Wire Line
	5850 7600 5850 7550
Connection ~ 5850 7550
$Comp
L power:GND #PWR0106
U 1 1 5C888411
P 6950 2900
F 0 "#PWR0106" H 6950 2650 50  0001 C CNN
F 1 "GND" H 6950 2750 50  0000 C CNN
F 2 "" H 6950 2900 50  0001 C CNN
F 3 "" H 6950 2900 50  0001 C CNN
	1    6950 2900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0107
U 1 1 5C888567
P 6950 1800
F 0 "#PWR0107" H 6950 1650 50  0001 C CNN
F 1 "VCC" H 6950 1950 50  0000 C CNN
F 2 "" H 6950 1800 50  0001 C CNN
F 3 "" H 6950 1800 50  0001 C CNN
	1    6950 1800
	1    0    0    -1  
$EndComp
Connection ~ 6950 1850
Wire Wire Line
	6950 1850 6950 1800
Wire Wire Line
	6950 2900 6950 2850
Connection ~ 6950 2850
$Comp
L power:VCC #PWR0108
U 1 1 5C8A4282
P 6100 4400
F 0 "#PWR0108" H 6100 4250 50  0001 C CNN
F 1 "VCC" H 6100 4550 50  0000 C CNN
F 2 "" H 6100 4400 50  0001 C CNN
F 3 "" H 6100 4400 50  0001 C CNN
	1    6100 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 4450 6100 4400
Connection ~ 6100 4450
$Comp
L power:VCC #PWR0109
U 1 1 5C8B13E5
P 9950 4400
F 0 "#PWR0109" H 9950 4250 50  0001 C CNN
F 1 "VCC" H 9950 4550 50  0000 C CNN
F 2 "" H 9950 4400 50  0001 C CNN
F 3 "" H 9950 4400 50  0001 C CNN
	1    9950 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 4450 9950 4400
Connection ~ 9950 4450
$Comp
L power:GND #PWR0110
U 1 1 5C8BE650
P 9950 6100
F 0 "#PWR0110" H 9950 5850 50  0001 C CNN
F 1 "GND" H 9950 5950 50  0000 C CNN
F 2 "" H 9950 6100 50  0001 C CNN
F 3 "" H 9950 6100 50  0001 C CNN
	1    9950 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 6100 9950 6050
$Comp
L power:GND #PWR0111
U 1 1 5C8CB96C
P 6100 6100
F 0 "#PWR0111" H 6100 5850 50  0001 C CNN
F 1 "GND" H 6100 5950 50  0000 C CNN
F 2 "" H 6100 6100 50  0001 C CNN
F 3 "" H 6100 6100 50  0001 C CNN
	1    6100 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 6100 6100 6050
Connection ~ 6100 6050
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5C8E62E8
P 10550 1000
F 0 "#FLG0101" H 10550 1075 50  0001 C CNN
F 1 "PWR_FLAG" H 10550 1173 50  0000 C CNN
F 2 "" H 10550 1000 50  0001 C CNN
F 3 "~" H 10550 1000 50  0001 C CNN
	1    10550 1000
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5C8E6462
P 10900 950
F 0 "#FLG0102" H 10900 1025 50  0001 C CNN
F 1 "PWR_FLAG" H 10900 1124 50  0000 C CNN
F 2 "" H 10900 950 50  0001 C CNN
F 3 "~" H 10900 950 50  0001 C CNN
	1    10900 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 5C8E64C7
P 10900 1000
F 0 "#PWR0112" H 10900 750 50  0001 C CNN
F 1 "GND" H 10900 850 50  0000 C CNN
F 2 "" H 10900 1000 50  0001 C CNN
F 3 "" H 10900 1000 50  0001 C CNN
	1    10900 1000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0113
U 1 1 5C8E652C
P 10550 950
F 0 "#PWR0113" H 10550 800 50  0001 C CNN
F 1 "VCC" H 10550 1100 50  0000 C CNN
F 2 "" H 10550 950 50  0001 C CNN
F 3 "" H 10550 950 50  0001 C CNN
	1    10550 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10900 1000 10900 950 
Wire Wire Line
	10550 1000 10550 950 
Text Label 6100 3500 0    60   ~ 0
BUSCLK
Text Label 950  2700 0    60   ~ 0
BUSCLK
$Comp
L Diode:1N4148 D1
U 1 1 5C00B794
P 2400 2550
F 0 "D1" H 2400 2334 50  0000 C CNN
F 1 "1N4148" H 2400 2425 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2400 2375 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/1N4148_1N4448.pdf" H 2400 2550 50  0001 C CNN
	1    2400 2550
	-1   0    0    1   
$EndComp
Wire Wire Line
	1800 2600 950  2600
Wire Wire Line
	2050 2550 2250 2550
Wire Wire Line
	2550 2550 3200 2550
$EndSCHEMATC
