EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:TMS9918
LIBS:TMS9918-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Conn_01x39 J1
U 1 1 5A772849
P 750 2600
F 0 "J1" H 750 4600 50  0000 C CNN
F 1 "Conn_01x39" H 750 600 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x39_Pitch2.54mm" H 750 2600 50  0001 C CNN
F 3 "" H 750 2600 50  0001 C CNN
	1    750  2600
	-1   0    0    1   
$EndComp
$Comp
L 74LS574 U5
U 1 1 5A7779C0
P 7800 1650
F 0 "U5" H 7800 1650 50  0000 C CNN
F 1 "74LS574" H 7850 1300 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 7800 1650 50  0001 C CNN
F 3 "" H 7800 1650 50  0001 C CNN
	1    7800 1650
	1    0    0    -1  
$EndComp
$Comp
L 74LS574 U6
U 1 1 5A777A33
P 7800 2950
F 0 "U6" H 7800 2950 50  0000 C CNN
F 1 "74LS574" H 7850 2600 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 7800 2950 50  0001 C CNN
F 3 "" H 7800 2950 50  0001 C CNN
	1    7800 2950
	1    0    0    -1  
$EndComp
$Comp
L 74LS574 U7
U 1 1 5A777AC8
P 7800 4400
F 0 "U7" H 7800 4400 50  0000 C CNN
F 1 "74LS574" H 7850 4050 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 7800 4400 50  0001 C CNN
F 3 "" H 7800 4400 50  0001 C CNN
	1    7800 4400
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 2 1 5A777B56
P 6050 4350
F 0 "U4" H 6200 4450 50  0000 C CNN
F 1 "74HCT04" H 6250 4250 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 4350 50  0001 C CNN
F 3 "" H 6050 4350 50  0001 C CNN
	2    6050 4350
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 3 1 5A777CB6
P 6050 4800
F 0 "U4" H 6200 4900 50  0000 C CNN
F 1 "74HCT04" H 6250 4700 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 4800 50  0001 C CNN
F 3 "" H 6050 4800 50  0001 C CNN
	3    6050 4800
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 4 1 5A777D02
P 6050 3350
F 0 "U4" H 6200 3450 50  0000 C CNN
F 1 "74HCT04" H 6250 3250 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 3350 50  0001 C CNN
F 3 "" H 6050 3350 50  0001 C CNN
	4    6050 3350
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 5 1 5A778370
P 6050 5600
F 0 "U4" H 6200 5700 50  0000 C CNN
F 1 "74HCT04" H 6250 5500 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 5600 50  0001 C CNN
F 3 "" H 6050 5600 50  0001 C CNN
	5    6050 5600
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 1 1 5A77837C
P 6050 3900
F 0 "U4" H 6200 4000 50  0000 C CNN
F 1 "74HCT04" H 6250 3800 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 3900 50  0001 C CNN
F 3 "" H 6050 3900 50  0001 C CNN
	1    6050 3900
	1    0    0    -1  
$EndComp
Text Label 4700 1050 0    60   ~ 0
AD0
Text Label 4700 1150 0    60   ~ 0
AD1
Text Label 4700 1250 0    60   ~ 0
AD2
Text Label 4700 1350 0    60   ~ 0
AD3
Text Label 4700 1450 0    60   ~ 0
AD4
Text Label 4700 1550 0    60   ~ 0
AD5
Text Label 4700 1650 0    60   ~ 0
AD6
Text Label 4700 1750 0    60   ~ 0
AD7
Text Label 7100 1150 2    60   ~ 0
AD0
Text Label 7100 1250 2    60   ~ 0
AD1
Text Label 7100 1350 2    60   ~ 0
AD2
Text Label 7100 1450 2    60   ~ 0
AD3
Text Label 7100 1550 2    60   ~ 0
AD4
Text Label 7100 1650 2    60   ~ 0
AD5
Text Label 7100 1750 2    60   ~ 0
AD6
Text Label 7100 1850 2    60   ~ 0
AD7
Text Label 7100 2450 2    60   ~ 0
AD0
Text Label 7100 2550 2    60   ~ 0
AD1
Text Label 7100 2650 2    60   ~ 0
AD2
Text Label 7100 2750 2    60   ~ 0
AD3
Text Label 7100 2850 2    60   ~ 0
AD4
Text Label 7100 2950 2    60   ~ 0
AD5
Text Label 7100 3050 2    60   ~ 0
AD6
Text Label 7100 3150 2    60   ~ 0
AD7
Text Label 7100 3900 2    60   ~ 0
AD0
Text Label 7100 4000 2    60   ~ 0
AD1
Text Label 7100 4100 2    60   ~ 0
AD2
Text Label 7100 4200 2    60   ~ 0
AD3
Text Label 7100 4300 2    60   ~ 0
AD4
Text Label 7100 4400 2    60   ~ 0
AD5
Text Label 7100 4500 2    60   ~ 0
AD6
Text Label 7100 4600 2    60   ~ 0
AD7
Entry Wire Line
	5000 1750 5100 1650
Entry Wire Line
	5000 1650 5100 1550
Entry Wire Line
	5000 1550 5100 1450
Entry Wire Line
	5000 1450 5100 1350
Entry Wire Line
	5000 1350 5100 1250
Entry Wire Line
	5000 1250 5100 1150
Entry Wire Line
	5000 1150 5100 1050
Entry Wire Line
	5000 1050 5100 950 
Entry Wire Line
	6750 4500 6850 4600
Entry Wire Line
	6750 4400 6850 4500
Entry Wire Line
	6750 4300 6850 4400
Entry Wire Line
	6750 4200 6850 4300
Entry Wire Line
	6750 4100 6850 4200
Entry Wire Line
	6750 4000 6850 4100
Entry Wire Line
	6750 3900 6850 4000
Entry Wire Line
	6750 3800 6850 3900
Entry Wire Line
	6750 2350 6850 2450
Entry Wire Line
	6750 2450 6850 2550
Entry Wire Line
	6750 2550 6850 2650
Entry Wire Line
	6750 2650 6850 2750
Entry Wire Line
	6750 2750 6850 2850
Entry Wire Line
	6750 2850 6850 2950
Entry Wire Line
	6750 2950 6850 3050
Entry Wire Line
	6750 3050 6850 3150
Entry Wire Line
	6750 1050 6850 1150
Entry Wire Line
	6750 1150 6850 1250
Entry Wire Line
	6750 1250 6850 1350
Entry Wire Line
	6750 1350 6850 1450
Entry Wire Line
	6750 1450 6850 1550
Entry Wire Line
	6750 1550 6850 1650
Entry Wire Line
	6750 1650 6850 1750
Entry Wire Line
	6750 1750 6850 1850
Text Label 4700 1950 0    60   ~ 0
~RAS~
Text Label 4700 2050 0    60   ~ 0
~CAS~
$Comp
L GND #PWR01
U 1 1 5A77A6A2
P 7100 3500
F 0 "#PWR01" H 7100 3250 50  0001 C CNN
F 1 "GND" H 7100 3350 50  0000 C CNN
F 2 "" H 7100 3500 50  0001 C CNN
F 3 "" H 7100 3500 50  0001 C CNN
	1    7100 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5A77A6CE
P 7100 4950
F 0 "#PWR02" H 7100 4700 50  0001 C CNN
F 1 "GND" H 7100 4800 50  0000 C CNN
F 2 "" H 7100 4950 50  0001 C CNN
F 3 "" H 7100 4950 50  0001 C CNN
	1    7100 4950
	1    0    0    -1  
$EndComp
Text Label 7100 2050 2    60   ~ 0
~R~W
$Comp
L HM62256BLP-7 U8
U 1 1 5A77A9F9
P 9900 3300
F 0 "U8" H 9600 4200 50  0000 C CNN
F 1 "HM62256BLP-7" H 10300 2500 50  0000 C CNN
F 2 "Housings_DIP:DIP-28_W7.62mm_Socket" H 9900 3300 50  0001 C CIN
F 3 "" H 9900 3300 50  0001 C CNN
	1    9900 3300
	1    0    0    -1  
$EndComp
Entry Wire Line
	8650 1150 8750 1050
Entry Wire Line
	8650 1250 8750 1150
Entry Wire Line
	8650 1350 8750 1250
Entry Wire Line
	8650 1450 8750 1350
Entry Wire Line
	8650 1550 8750 1450
Entry Wire Line
	8650 1650 8750 1550
Entry Wire Line
	8650 1750 8750 1650
Entry Wire Line
	8650 1850 8750 1750
Entry Wire Line
	10850 2550 10950 2450
Entry Wire Line
	10850 2650 10950 2550
Entry Wire Line
	10850 2750 10950 2650
Entry Wire Line
	10850 2850 10950 2750
Entry Wire Line
	10850 2950 10950 2850
Entry Wire Line
	10850 3050 10950 2950
Entry Wire Line
	10850 3150 10950 3050
Entry Wire Line
	10850 3250 10950 3150
NoConn ~ 8500 2450
NoConn ~ 8500 3900
Text Label 8500 1150 0    60   ~ 0
VD0
Text Label 8500 1250 0    60   ~ 0
VD1
Text Label 8500 1350 0    60   ~ 0
VD2
Text Label 8500 1450 0    60   ~ 0
VD3
Text Label 8500 1550 0    60   ~ 0
VD4
Text Label 8500 1650 0    60   ~ 0
VD5
Text Label 8500 1750 0    60   ~ 0
VD6
Text Label 8500 1850 0    60   ~ 0
VD7
Entry Wire Line
	5000 2350 5100 2450
Entry Wire Line
	5000 2450 5100 2550
Entry Wire Line
	5000 2550 5100 2650
Entry Wire Line
	5000 2650 5100 2750
Entry Wire Line
	5000 2750 5100 2850
Entry Wire Line
	5000 2850 5100 2950
Entry Wire Line
	5000 2950 5100 3050
Entry Wire Line
	5000 3050 5100 3150
$Comp
L VCC #PWR03
U 1 1 5A782469
P 3950 700
F 0 "#PWR03" H 3950 550 50  0001 C CNN
F 1 "VCC" H 3950 850 50  0000 C CNN
F 2 "" H 3950 700 50  0001 C CNN
F 3 "" H 3950 700 50  0001 C CNN
	1    3950 700 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 5A782608
P 3950 3950
F 0 "#PWR04" H 3950 3700 50  0001 C CNN
F 1 "GND" H 3950 3800 50  0000 C CNN
F 2 "" H 3950 3950 50  0001 C CNN
F 3 "" H 3950 3950 50  0001 C CNN
	1    3950 3950
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5A782922
P 2500 3700
F 0 "C1" H 2400 3800 50  0000 L CNN
F 1 "16pf" H 2525 3600 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 2538 3550 50  0001 C CNN
F 3 "" H 2500 3700 50  0001 C CNN
	1    2500 3700
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 5A782C60
P 3100 3700
F 0 "C2" H 3125 3800 50  0000 L CNN
F 1 "16pf" H 3125 3600 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 3138 3550 50  0001 C CNN
F 3 "" H 3100 3700 50  0001 C CNN
	1    3100 3700
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 5A782C91
P 3700 5100
F 0 "C3" H 3725 5200 50  0000 L CNN
F 1 "0.1uf" H 3725 5000 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 3738 4950 50  0001 C CNN
F 3 "" H 3700 5100 50  0001 C CNN
	1    3700 5100
	-1   0    0    -1  
$EndComp
$Comp
L Q_NPN_EBC Q1
U 1 1 5A782EC0
P 4550 5150
F 0 "Q1" H 4750 5200 50  0000 L CNN
F 1 "2N4401" H 4750 5100 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-92_Molded_Narrow" H 4750 5250 50  0001 C CNN
F 3 "" H 4550 5150 50  0001 C CNN
	1    4550 5150
	-1   0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5A782FE1
P 4800 4600
F 0 "R2" V 4880 4600 50  0000 C CNN
F 1 "0" V 4800 4600 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4730 4600 50  0001 C CNN
F 3 "" H 4800 4600 50  0001 C CNN
	1    4800 4600
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5A783262
P 4800 5750
F 0 "R3" V 4880 5750 50  0000 C CNN
F 1 "470" V 4800 5750 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4730 5750 50  0001 C CNN
F 3 "" H 4800 5750 50  0001 C CNN
	1    4800 5750
	-1   0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5A783339
P 4450 5750
F 0 "R1" V 4530 5750 50  0000 C CNN
F 1 "75" V 4450 5750 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4380 5750 50  0001 C CNN
F 3 "" H 4450 5750 50  0001 C CNN
	1    4450 5750
	-1   0    0    -1  
$EndComp
$Comp
L Ferrite_Bead L1
U 1 1 5A7833DE
P 3700 4600
F 0 "L1" V 3550 4625 50  0000 C CNN
F 1 "Ferrite_Bead" V 3850 4600 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3630 4600 50  0001 C CNN
F 3 "" H 3700 4600 50  0001 C CNN
	1    3700 4600
	-1   0    0    -1  
$EndComp
$Comp
L Conn_Coaxial J2
U 1 1 5A78351D
P 4150 5500
F 0 "J2" H 4160 5620 50  0000 C CNN
F 1 "Conn_Coaxial" V 4265 5500 50  0000 C CNN
F 2 "w_conn_av:KLPX-0848A" H 4150 5500 50  0001 C CNN
F 3 "" H 4150 5500 50  0001 C CNN
	1    4150 5500
	-1   0    0    -1  
$EndComp
$Comp
L Crystal Y1
U 1 1 5A7835AA
P 2800 3450
F 0 "Y1" H 2800 3600 50  0000 C CNN
F 1 "10.738635MHz" H 2800 3300 50  0000 C CNN
F 2 "Crystals:Crystal_HC49-4H_Vertical" H 2800 3450 50  0001 C CNN
F 3 "" H 2800 3450 50  0001 C CNN
	1    2800 3450
	1    0    0    -1  
$EndComp
$Comp
L TMS9918A U3
U 1 1 5A78610F
P 3950 2250
F 0 "U3" H 3450 3650 60  0000 C CNN
F 1 "TMS9918A" H 4300 850 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 4000 2350 60  0001 C CNN
F 3 "" H 4000 2350 60  0001 C CNN
	1    3950 2250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR05
U 1 1 5A786C7D
P 3700 4350
F 0 "#PWR05" H 3700 4200 50  0001 C CNN
F 1 "VCC" H 3700 4500 50  0000 C CNN
F 2 "" H 3700 4350 50  0001 C CNN
F 3 "" H 3700 4350 50  0001 C CNN
	1    3700 4350
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5A78728F
P 4150 5950
F 0 "#PWR06" H 4150 5700 50  0001 C CNN
F 1 "GND" H 4150 5800 50  0000 C CNN
F 2 "" H 4150 5950 50  0001 C CNN
F 3 "" H 4150 5950 50  0001 C CNN
	1    4150 5950
	-1   0    0    -1  
$EndComp
Text Label 10400 2550 0    60   ~ 0
VD0
Text Label 10400 2650 0    60   ~ 0
VD1
Text Label 10400 2750 0    60   ~ 0
VD2
Text Label 10400 2850 0    60   ~ 0
VD3
Text Label 10400 2950 0    60   ~ 0
VD4
Text Label 10400 3050 0    60   ~ 0
VD5
Text Label 10400 3150 0    60   ~ 0
VD6
Text Label 10400 3250 0    60   ~ 0
VD7
Text Label 10400 3500 0    60   ~ 0
R~W~
Text Label 10400 3400 0    60   ~ 0
~R~W
Text Label 10400 3650 0    60   ~ 0
~CAS~
Text Label 4700 2150 0    60   ~ 0
R~W~
$Comp
L C C4
U 1 1 5A79986C
P 5050 6400
F 0 "C4" H 5075 6500 50  0000 L CNN
F 1 "0.1uf" H 5075 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5088 6250 50  0001 C CNN
F 3 "" H 5050 6400 50  0001 C CNN
	1    5050 6400
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 5A799A39
P 5350 6400
F 0 "C5" H 5375 6500 50  0000 L CNN
F 1 "0.1uf" H 5375 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5388 6250 50  0001 C CNN
F 3 "" H 5350 6400 50  0001 C CNN
	1    5350 6400
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 5A799A9F
P 5650 6400
F 0 "C6" H 5675 6500 50  0000 L CNN
F 1 "0.1uf" H 5675 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5688 6250 50  0001 C CNN
F 3 "" H 5650 6400 50  0001 C CNN
	1    5650 6400
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5A799B12
P 5950 6400
F 0 "C7" H 5975 6500 50  0000 L CNN
F 1 "0.1uf" H 5975 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5988 6250 50  0001 C CNN
F 3 "" H 5950 6400 50  0001 C CNN
	1    5950 6400
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 5A799B88
P 6200 6400
F 0 "C8" H 6225 6500 50  0000 L CNN
F 1 "0.1uf" H 6225 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6238 6250 50  0001 C CNN
F 3 "" H 6200 6400 50  0001 C CNN
	1    6200 6400
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 5A799BEF
P 6450 6400
F 0 "C9" H 6475 6500 50  0000 L CNN
F 1 "0.1uf" H 6475 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6488 6250 50  0001 C CNN
F 3 "" H 6450 6400 50  0001 C CNN
	1    6450 6400
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR07
U 1 1 5A79A0B1
P 5950 6200
F 0 "#PWR07" H 5950 6050 50  0001 C CNN
F 1 "VCC" H 5950 6350 50  0000 C CNN
F 2 "" H 5950 6200 50  0001 C CNN
F 3 "" H 5950 6200 50  0001 C CNN
	1    5950 6200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5A79A0FD
P 5950 6600
F 0 "#PWR08" H 5950 6350 50  0001 C CNN
F 1 "GND" H 5950 6450 50  0000 C CNN
F 2 "" H 5950 6600 50  0001 C CNN
F 3 "" H 5950 6600 50  0001 C CNN
	1    5950 6600
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 5A79AE12
P 6700 6400
F 0 "C10" H 6725 6500 50  0000 L CNN
F 1 "0.1uf" H 6725 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6738 6250 50  0001 C CNN
F 3 "" H 6700 6400 50  0001 C CNN
	1    6700 6400
	1    0    0    -1  
$EndComp
Text Label 3200 1750 2    60   ~ 0
D0
Text Label 3200 1650 2    60   ~ 0
D1
Text Label 3200 1550 2    60   ~ 0
D2
Text Label 3200 1450 2    60   ~ 0
D3
Text Label 3200 1350 2    60   ~ 0
D4
Text Label 3200 1250 2    60   ~ 0
D5
Text Label 3200 1150 2    60   ~ 0
D6
Text Label 3200 1050 2    60   ~ 0
D7
Text Label 950  1900 0    60   ~ 0
D0
Text Label 950  1800 0    60   ~ 0
D1
Text Label 950  1700 0    60   ~ 0
D2
Text Label 950  1600 0    60   ~ 0
D3
Text Label 950  1500 0    60   ~ 0
D4
Text Label 950  1400 0    60   ~ 0
D5
Text Label 950  1300 0    60   ~ 0
D6
Text Label 950  1200 0    60   ~ 0
D7
Text Label 4700 2350 0    60   ~ 0
VD0
Text Label 4700 2450 0    60   ~ 0
VD1
Text Label 4700 2550 0    60   ~ 0
VD2
Text Label 4700 2650 0    60   ~ 0
VD3
Text Label 4700 2750 0    60   ~ 0
VD4
Text Label 4700 2850 0    60   ~ 0
VD5
Text Label 4700 2950 0    60   ~ 0
VD6
Text Label 4700 3050 0    60   ~ 0
VD7
Text Label 8500 2550 0    60   ~ 0
VA0
Text Label 8500 2650 0    60   ~ 0
VA1
Text Label 8500 2750 0    60   ~ 0
VA2
Text Label 8500 2850 0    60   ~ 0
VA3
Text Label 8500 2950 0    60   ~ 0
VA4
Text Label 8500 3050 0    60   ~ 0
VA5
Text Label 8500 3150 0    60   ~ 0
VA6
Text Label 8500 4000 0    60   ~ 0
VA7
Text Label 8500 4100 0    60   ~ 0
VA8
Text Label 8500 4200 0    60   ~ 0
VA9
Text Label 8500 4300 0    60   ~ 0
VA10
Text Label 8500 4400 0    60   ~ 0
VA11
Text Label 8500 4500 0    60   ~ 0
VA12
Text Label 8500 4600 0    60   ~ 0
VA13
$Comp
L GND #PWR09
U 1 1 5A79E376
P 1250 2900
F 0 "#PWR09" H 1250 2650 50  0001 C CNN
F 1 "GND" H 1250 2750 50  0000 C CNN
F 2 "" H 1250 2900 50  0001 C CNN
F 3 "" H 1250 2900 50  0001 C CNN
	1    1250 2900
	-1   0    0    -1  
$EndComp
$Comp
L VCC #PWR010
U 1 1 5A79E6FF
P 1250 2800
F 0 "#PWR010" H 1250 2650 50  0001 C CNN
F 1 "VCC" H 1250 2950 50  0000 C CNN
F 2 "" H 1250 2800 50  0001 C CNN
F 3 "" H 1250 2800 50  0001 C CNN
	1    1250 2800
	-1   0    0    -1  
$EndComp
NoConn ~ 950  700 
NoConn ~ 950  800 
NoConn ~ 950  900 
NoConn ~ 950  1000
NoConn ~ 950  1100
NoConn ~ 950  2300
NoConn ~ 950  2700
NoConn ~ 950  2500
NoConn ~ 950  4500
NoConn ~ 950  4400
NoConn ~ 950  4300
NoConn ~ 950  4200
NoConn ~ 950  4100
Text Label 950  3000 0    60   ~ 0
A0
Text Label 950  3400 0    60   ~ 0
A4
Text Label 950  3500 0    60   ~ 0
A5
Text Label 950  3600 0    60   ~ 0
A6
Text Label 950  3700 0    60   ~ 0
A7
Text Label 950  2600 0    60   ~ 0
~RESET~
Text Label 950  2400 0    60   ~ 0
~INT~
Text Label 950  2100 0    60   ~ 0
~RD~
Text Label 950  2000 0    60   ~ 0
~IORQ~
Text Label 7100 3350 2    60   ~ 0
ROW
Text Label 7100 4800 2    60   ~ 0
COL
Text Label 3200 2050 2    60   ~ 0
~CSW~
Text Label 3200 2150 2    60   ~ 0
~CSR~
$Comp
L 74HCT04 U4
U 6 1 5A7A42CA
P 1300 6350
F 0 "U4" H 1450 6450 50  0000 C CNN
F 1 "74HCT04" H 1500 6250 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 1300 6350 50  0001 C CNN
F 3 "" H 1300 6350 50  0001 C CNN
	6    1300 6350
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 1 1 5A7CFD14
P 1350 5050
F 0 "U1" H 1350 5100 50  0000 C CNN
F 1 "74LS32" H 1350 5000 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 1350 5050 50  0001 C CNN
F 3 "" H 1350 5050 50  0001 C CNN
	1    1350 5050
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 3 1 5A7CFDCF
P 5250 7050
F 0 "U1" H 5250 7100 50  0000 C CNN
F 1 "74LS32" H 5250 7000 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 5250 7050 50  0001 C CNN
F 3 "" H 5250 7050 50  0001 C CNN
	3    5250 7050
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 2 1 5A7CFEC8
P 5250 7550
F 0 "U1" H 5250 7600 50  0000 C CNN
F 1 "74LS32" H 5250 7500 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 5250 7550 50  0001 C CNN
F 3 "" H 5250 7550 50  0001 C CNN
	2    5250 7550
	1    0    0    -1  
$EndComp
NoConn ~ 950  4000
NoConn ~ 950  3900
NoConn ~ 950  3800
Text Label 950  2200 0    60   ~ 0
~WR~
Text Label 950  3100 0    60   ~ 0
A1
Text Label 950  3200 0    60   ~ 0
A2
Text Label 950  3300 0    60   ~ 0
A3
Text Label 2850 7100 2    60   ~ 0
~ADDR~
$Comp
L C C11
U 1 1 5A7DB855
P 4800 6400
F 0 "C11" H 4825 6500 50  0000 L CNN
F 1 "0.1uf" H 4825 6300 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 4838 6250 50  0001 C CNN
F 3 "" H 4800 6400 50  0001 C CNN
	1    4800 6400
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x14 J3
U 1 1 5B0E0805
P 10250 1600
F 0 "J3" H 10250 2300 50  0000 C CNN
F 1 "Conn_01x14" H 10250 800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x14_Pitch2.54mm" H 10250 1600 50  0001 C CNN
F 3 "" H 10250 1600 50  0001 C CNN
	1    10250 1600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR011
U 1 1 5B0E4F37
P 9650 2300
F 0 "#PWR011" H 9650 2150 50  0001 C CNN
F 1 "VCC" H 9650 2450 50  0000 C CNN
F 2 "" H 9650 2300 50  0001 C CNN
F 3 "" H 9650 2300 50  0001 C CNN
	1    9650 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3450 4700 3450
Wire Wire Line
	4800 4450 4800 3450
Connection ~ 4800 5150
Wire Wire Line
	4800 5150 4750 5150
Wire Wire Line
	4800 4750 4800 5600
Connection ~ 4450 5900
Connection ~ 4150 5900
Wire Wire Line
	3700 5900 3700 5250
Connection ~ 3700 4900
Wire Wire Line
	3700 4750 3700 4950
Wire Wire Line
	4450 4900 3700 4900
Wire Wire Line
	4450 4950 4450 4900
Wire Wire Line
	4150 5700 4150 5950
Wire Wire Line
	3700 5900 4800 5900
Connection ~ 4450 5500
Wire Wire Line
	4450 5500 4300 5500
Wire Wire Line
	4450 5350 4450 5600
Wire Wire Line
	3700 4350 3700 4450
Connection ~ 3950 3850
Connection ~ 3100 3850
Wire Wire Line
	2500 3850 3950 3850
Connection ~ 2500 3450
Wire Wire Line
	2500 3050 3200 3050
Wire Wire Line
	2500 3050 2500 3550
Wire Wire Line
	2650 3450 2500 3450
Connection ~ 3100 3450
Wire Wire Line
	3100 3550 3100 3450
Wire Wire Line
	2950 3450 3200 3450
Wire Wire Line
	3950 3750 3950 3950
Wire Wire Line
	3950 750  3950 700 
Wire Wire Line
	4700 1950 5550 1950
Wire Wire Line
	4700 3050 5000 3050
Wire Wire Line
	4700 2950 5000 2950
Wire Wire Line
	4700 2850 5000 2850
Wire Wire Line
	4700 2750 5000 2750
Wire Wire Line
	4700 2650 5000 2650
Wire Wire Line
	4700 2550 5000 2550
Wire Wire Line
	4700 2450 5000 2450
Wire Wire Line
	4700 2350 5000 2350
Wire Wire Line
	5250 5600 5600 5600
Wire Bus Line
	5100 2450 5100 5850
Wire Bus Line
	5100 5850 10950 5850
Wire Bus Line
	5100 950  6750 950 
Wire Wire Line
	6500 5600 10800 5600
Connection ~ 5250 5400
Wire Wire Line
	5250 5400 10650 5400
Wire Wire Line
	5400 5250 10500 5250
Wire Wire Line
	6500 3350 7100 3350
Wire Wire Line
	6500 4800 7100 4800
Wire Wire Line
	5550 3350 5600 3350
Connection ~ 5400 3900
Wire Wire Line
	5400 3900 5600 3900
Wire Wire Line
	5550 1950 5550 3350
Wire Wire Line
	10800 5600 10800 3400
Wire Wire Line
	5250 2150 5250 5600
Wire Bus Line
	10950 5850 10950 900 
Wire Wire Line
	5400 2050 5400 5250
Wire Wire Line
	10500 5250 10500 3650
Wire Wire Line
	10500 3650 10400 3650
Wire Wire Line
	10650 3500 10400 3500
Wire Wire Line
	10650 5400 10650 3500
Wire Wire Line
	10800 3400 10400 3400
Wire Wire Line
	10400 3250 10850 3250
Wire Wire Line
	10400 3150 10850 3150
Wire Wire Line
	10400 3050 10850 3050
Wire Wire Line
	10400 2950 10850 2950
Wire Wire Line
	10400 2850 10850 2850
Wire Wire Line
	10400 2750 10850 2750
Wire Wire Line
	10400 2650 10850 2650
Wire Wire Line
	10400 2550 10850 2550
Wire Wire Line
	8500 1850 8650 1850
Wire Wire Line
	8500 1750 8650 1750
Wire Wire Line
	8500 1650 8650 1650
Wire Wire Line
	8500 1550 8650 1550
Wire Wire Line
	8500 1450 8650 1450
Wire Wire Line
	8500 1350 8650 1350
Wire Wire Line
	8500 1250 8650 1250
Wire Wire Line
	8500 1150 8650 1150
Wire Bus Line
	8750 900  8750 1750
Wire Bus Line
	10950 900  8750 900 
Wire Wire Line
	4700 2150 7100 2150
Wire Wire Line
	6650 2050 7100 2050
Wire Wire Line
	7100 4950 7100 4900
Wire Wire Line
	7100 3500 7100 3450
Wire Wire Line
	5550 4800 5600 4800
Wire Wire Line
	5550 4600 5550 4800
Wire Wire Line
	6550 4600 5550 4600
Wire Wire Line
	6550 4350 6550 4600
Wire Wire Line
	6500 4350 6550 4350
Wire Wire Line
	5550 4350 5600 4350
Wire Wire Line
	5550 4150 5550 4350
Wire Wire Line
	6550 4150 5550 4150
Wire Wire Line
	6550 3900 6550 4150
Wire Wire Line
	6500 3900 6550 3900
Wire Wire Line
	4700 2050 5400 2050
Wire Bus Line
	5100 950  5100 1650
Wire Bus Line
	6750 950  6750 4500
Wire Wire Line
	4700 1750 5000 1750
Wire Wire Line
	4700 1650 5000 1650
Wire Wire Line
	4700 1550 5000 1550
Wire Wire Line
	4700 1450 5000 1450
Wire Wire Line
	4700 1350 5000 1350
Wire Wire Line
	5000 1250 4700 1250
Wire Wire Line
	4700 1150 5000 1150
Wire Wire Line
	4700 1050 5000 1050
Wire Wire Line
	6850 3150 7100 3150
Wire Wire Line
	6850 3050 7100 3050
Wire Wire Line
	6850 2950 7100 2950
Wire Wire Line
	6850 2850 7100 2850
Wire Wire Line
	6850 2750 7100 2750
Wire Wire Line
	6850 2650 7100 2650
Wire Wire Line
	6850 2550 7100 2550
Wire Wire Line
	6850 2450 7100 2450
Wire Wire Line
	6850 3900 7100 3900
Wire Wire Line
	6850 4000 7100 4000
Wire Wire Line
	6850 4100 7100 4100
Wire Wire Line
	6850 4200 7100 4200
Wire Wire Line
	6850 4300 7100 4300
Wire Wire Line
	6850 4400 7100 4400
Wire Wire Line
	6850 4500 7100 4500
Wire Wire Line
	6850 4600 7100 4600
Wire Wire Line
	6850 1850 7100 1850
Wire Wire Line
	6850 1750 7100 1750
Wire Wire Line
	6850 1650 7100 1650
Wire Wire Line
	6850 1550 7100 1550
Wire Wire Line
	6850 1450 7100 1450
Wire Wire Line
	6850 1350 7100 1350
Wire Wire Line
	6850 1250 7100 1250
Wire Wire Line
	6850 1150 7100 1150
Connection ~ 5250 2150
Wire Wire Line
	6650 5600 6650 2050
Connection ~ 6650 5600
Wire Wire Line
	4800 6250 6700 6250
Connection ~ 5350 6250
Connection ~ 5650 6250
Wire Wire Line
	5950 6250 5950 6200
Connection ~ 5950 6250
Connection ~ 6200 6250
Connection ~ 6450 6250
Wire Wire Line
	4800 6550 6700 6550
Connection ~ 6450 6550
Connection ~ 6200 6550
Wire Wire Line
	5950 6550 5950 6600
Connection ~ 5950 6550
Connection ~ 5650 6550
Connection ~ 5350 6550
Wire Wire Line
	950  2800 1250 2800
Connection ~ 5050 6250
Connection ~ 5050 6550
Wire Wire Line
	9650 2300 10050 2300
Text Label 10050 1000 2    60   ~ 0
VD3
Text Label 10050 1100 2    60   ~ 0
VD4
Text Label 10050 1200 2    60   ~ 0
VD5
Text Label 10050 1300 2    60   ~ 0
VD6
Text Label 10050 1400 2    60   ~ 0
VD7
Text Label 10050 1500 2    60   ~ 0
~CAS~
Text Label 10050 1600 2    60   ~ 0
VA4
Text Label 10050 1700 2    60   ~ 0
~R~W
Text Label 10050 1800 2    60   ~ 0
VA7
Text Label 10050 1900 2    60   ~ 0
VA10
Text Label 10050 2000 2    60   ~ 0
VA12
Text Label 10050 2100 2    60   ~ 0
VA13
Text Label 10050 2200 2    60   ~ 0
R~W~
$Comp
L Conn_02x08_Odd_Even J4
U 1 1 5B1E36E0
P 2200 7100
F 0 "J4" H 2250 7500 50  0000 C CNN
F 1 "Conn_02x08_Odd_Even" H 2250 6600 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x08_Pitch2.54mm" H 2200 7100 50  0001 C CNN
F 3 "" H 2200 7100 50  0001 C CNN
	1    2200 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6800 2000 6800
Wire Wire Line
	1950 6900 2000 6900
Wire Wire Line
	1950 7000 2000 7000
Wire Wire Line
	1950 7100 2000 7100
Wire Wire Line
	1950 7200 2000 7200
Wire Wire Line
	1950 7300 2000 7300
Wire Wire Line
	1950 7400 2000 7400
Wire Wire Line
	1950 7500 2000 7500
Wire Wire Line
	2550 7500 2500 7500
Wire Wire Line
	2550 6800 2500 6800
Wire Wire Line
	2550 6900 2500 6900
Connection ~ 2550 6900
Wire Wire Line
	2550 7000 2500 7000
Connection ~ 2550 7000
Wire Wire Line
	2500 7100 2850 7100
Connection ~ 2550 7100
Wire Wire Line
	2500 7200 2550 7200
Connection ~ 2550 7200
Wire Wire Line
	2550 7300 2500 7300
Connection ~ 2550 7300
Wire Wire Line
	2500 7400 2550 7400
Connection ~ 2550 7400
Text Label 750  7000 2    60   ~ 0
A7
Text Label 750  6900 2    60   ~ 0
A6
Text Label 750  7300 2    60   ~ 0
E3
Text Label 750  7400 2    60   ~ 0
~E2~
Text Label 750  6800 2    60   ~ 0
A5
Text Label 750  7500 2    60   ~ 0
~E1~
$Comp
L 74LS32 U1
U 4 1 5A7CFBC7
P 3450 7200
F 0 "U1" H 3450 7250 50  0000 C CNN
F 1 "74LS32" H 3450 7150 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 3450 7200 50  0001 C CNN
F 3 "" H 3450 7200 50  0001 C CNN
	4    3450 7200
	1    0    0    -1  
$EndComp
Connection ~ 2550 6800
$Comp
L 74LS138 U2
U 1 1 5B25AE81
P 1350 7150
F 0 "U2" H 1450 7650 50  0000 C CNN
F 1 "74LS138" H 1500 6601 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 1350 7150 50  0001 C CNN
F 3 "" H 1350 7150 50  0001 C CNN
	1    1350 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 5300 2450 5300
Text Label 2450 5300 2    60   ~ 0
~E1~
Text Label 750  4950 2    60   ~ 0
A1
Text Label 750  5150 2    60   ~ 0
A2
Text Label 750  5600 2    60   ~ 0
A3
$Comp
L Jumper_NC_Dual JP1
U 1 1 5B4BE5F8
P 2250 5050
F 0 "JP1" H 2300 4950 50  0000 L CNN
F 1 "A1/A2" H 2250 5150 50  0000 C BNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 5050 50  0001 C CNN
F 3 "" H 2250 5050 50  0001 C CNN
	1    2250 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 5050 2000 5050
Wire Wire Line
	2250 5150 2250 5300
Wire Wire Line
	2250 5850 2450 5850
Text Label 2450 5850 2    60   ~ 0
~E2~
$Comp
L Jumper_NC_Dual JP2
U 1 1 5B4BEF99
P 2250 5600
F 0 "JP2" H 2300 5500 50  0000 L CNN
F 1 "A3" H 2250 5700 50  0000 C BNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 5600 50  0001 C CNN
F 3 "" H 2250 5600 50  0001 C CNN
	1    2250 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 5700 2250 5850
Text Label 2650 6250 2    60   ~ 0
E3
$Comp
L GND #PWR012
U 1 1 5B4BF4D4
P 2650 5050
F 0 "#PWR012" H 2650 4800 50  0001 C CNN
F 1 "GND" H 2650 4900 50  0000 C CNN
F 2 "" H 2650 5050 50  0001 C CNN
F 3 "" H 2650 5050 50  0001 C CNN
	1    2650 5050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 5B4BF557
P 2650 5600
F 0 "#PWR013" H 2650 5350 50  0001 C CNN
F 1 "GND" H 2650 5450 50  0000 C CNN
F 2 "" H 2650 5600 50  0001 C CNN
F 3 "" H 2650 5600 50  0001 C CNN
	1    2650 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 5050 2650 5050
Wire Wire Line
	2500 5600 2650 5600
$Comp
L VCC #PWR014
U 1 1 5B4BF9CF
P 2000 6100
F 0 "#PWR014" H 2000 5950 50  0001 C CNN
F 1 "VCC" H 2000 6250 50  0000 C CNN
F 2 "" H 2000 6100 50  0001 C CNN
F 3 "" H 2000 6100 50  0001 C CNN
	1    2000 6100
	1    0    0    -1  
$EndComp
Text Label 2850 7300 2    60   ~ 0
~IORQ~
Text Label 5850 7550 0    60   ~ 0
~CSW~
Text Label 5850 7050 0    60   ~ 0
~CSR~
Text Label 4650 6950 2    60   ~ 0
~IORQ+ADDR~
Text Label 4650 7650 2    60   ~ 0
~WR~
Wire Wire Line
	2550 6800 2550 7500
Wire Wire Line
	950  2900 1250 2900
Wire Wire Line
	4100 6950 4650 6950
Wire Wire Line
	4100 6950 4100 7450
Wire Wire Line
	4100 7450 4650 7450
Text Label 4650 7150 2    60   ~ 0
~RD~
Wire Wire Line
	2000 5600 750  5600
Text Label 1750 6350 0    60   ~ 0
~A4~
Text Label 3200 1950 2    60   ~ 0
A0
Text Label 3200 2450 2    60   ~ 0
~RESET~
$Comp
L Jumper_NC_Dual JP4
U 1 1 5B4C882E
P 1800 1950
F 0 "JP4" H 1850 1850 50  0000 L CNN
F 1 "Jumper_NC_Dual" H 1800 2050 50  0000 C BNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1800 1950 50  0001 C CNN
F 3 "" H 1800 1950 50  0001 C CNN
	1    1800 1950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3200 2350 2050 2350
Wire Wire Line
	2050 2350 2050 1950
Wire Wire Line
	2050 1950 1900 1950
Wire Wire Line
	1800 1700 1800 1450
Wire Wire Line
	1800 2200 1800 2400
Wire Wire Line
	1800 2400 950  2400
$Comp
L Conn_02x03_Odd_Even J6
U 1 1 5B562712
P 2200 6250
F 0 "J6" H 2250 6450 50  0000 C CNN
F 1 "A4" H 2250 6050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 2200 6250 50  0001 C CNN
F 3 "" H 2200 6250 50  0001 C CNN
	1    2200 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 6150 2000 6100
Wire Wire Line
	2500 6150 2500 6350
Connection ~ 2500 6250
Wire Wire Line
	850  6350 750  6350
Wire Wire Line
	2500 6250 2650 6250
Text Label 750  6350 2    60   ~ 0
A4
Connection ~ 800  6350
Wire Wire Line
	4050 7200 4100 7200
Connection ~ 4100 7200
Wire Wire Line
	1750 6350 2000 6350
Wire Wire Line
	800  6350 800  6150
Wire Wire Line
	800  6150 1950 6150
Wire Wire Line
	1950 6150 1950 6250
Wire Wire Line
	1950 6250 2000 6250
$Comp
L Conn_01x04 J7
U 1 1 5B565167
P 1400 4250
F 0 "J7" H 1400 4450 50  0000 C CNN
F 1 "Conn_01x04" H 1400 3950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 1400 4250 50  0001 C CNN
F 3 "" H 1400 4250 50  0001 C CNN
	1    1400 4250
	-1   0    0    -1  
$EndComp
Text Label 3200 2350 2    60   ~ 0
~INTNMI~
Text Label 1800 1450 0    60   ~ 0
~NMI~
Text Label 4700 3250 0    60   ~ 0
EXTVDP
Text Label 1600 4250 0    60   ~ 0
GROMCLK
Text Label 1600 4150 0    60   ~ 0
CPUCLK
Text Label 1600 4350 0    60   ~ 0
EXTVDP
$Comp
L GND #PWR015
U 1 1 5B565AEA
P 1750 4450
F 0 "#PWR015" H 1750 4200 50  0001 C CNN
F 1 "GND" H 1750 4300 50  0000 C CNN
F 2 "" H 1750 4450 50  0001 C CNN
F 3 "" H 1750 4450 50  0001 C CNN
	1    1750 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 4450 1750 4450
Text Label 3200 2700 2    60   ~ 0
GROMCLK
Text Label 3200 2800 2    60   ~ 0
CPUCLK
$Comp
L Conn_01x10 J5
U 1 1 5B5672B7
P 1600 950
F 0 "J5" H 1600 1450 50  0000 C CNN
F 1 "Conn_01x10" H 1600 350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x10_Pitch2.54mm" H 1600 950 50  0001 C CNN
F 3 "" H 1600 950 50  0001 C CNN
	1    1600 950 
	-1   0    0    -1  
$EndComp
NoConn ~ 1800 1350
NoConn ~ 1800 1250
NoConn ~ 1800 1150
NoConn ~ 1800 1050
NoConn ~ 1800 950 
NoConn ~ 1800 850 
NoConn ~ 1800 750 
$Comp
L GND #PWR016
U 1 1 5B567544
P 2300 550
F 0 "#PWR016" H 2300 300 50  0001 C CNN
F 1 "GND" H 2300 400 50  0000 C CNN
F 2 "" H 2300 550 50  0001 C CNN
F 3 "" H 2300 550 50  0001 C CNN
	1    2300 550 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 550  2300 550 
$Comp
L VCC #PWR017
U 1 1 5B5676EA
P 2100 800
F 0 "#PWR017" H 2100 650 50  0001 C CNN
F 1 "VCC" H 2100 950 50  0000 C CNN
F 2 "" H 2100 800 50  0001 C CNN
F 3 "" H 2100 800 50  0001 C CNN
	1    2100 800 
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1800 650  1950 650 
Wire Wire Line
	1950 650  1950 800 
Wire Wire Line
	1950 800  2100 800 
Text Label 9400 3950 2    60   ~ 0
VA13
Text Label 9400 3850 2    60   ~ 0
VA13
Text Label 9400 3350 2    60   ~ 0
VA12
Text Label 9400 3750 2    60   ~ 0
VA11
Text Label 9400 3450 2    60   ~ 0
VA10
Text Label 9400 3250 2    60   ~ 0
VA9
Text Label 9400 3150 2    60   ~ 0
VA8
Text Label 9400 3650 2    60   ~ 0
VA7
Text Label 9400 2550 2    60   ~ 0
VA0
Text Label 9400 2650 2    60   ~ 0
VA1
Text Label 9400 2750 2    60   ~ 0
VA2
Text Label 9400 2850 2    60   ~ 0
VA3
Text Label 9400 2950 2    60   ~ 0
VA5
Text Label 9400 3050 2    60   ~ 0
VA6
Text Label 9400 3550 2    60   ~ 0
VA4
$EndSCHEMATC
