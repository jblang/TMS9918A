EESchema Schematic File Version 2
LIBS:TMS9918-rescue
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
P 2600 7400
F 0 "J1" H 2600 9400 50  0000 C CNN
F 1 "Conn_01x39" H 2600 5400 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x39_Pitch2.54mm" H 2600 7400 50  0001 C CNN
F 3 "" H 2600 7400 50  0001 C CNN
	1    2600 7400
	0    -1   1    0   
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
P 6050 3900
F 0 "U4" H 6200 4000 50  0000 C CNN
F 1 "74HCT04" H 6250 3800 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 3900 50  0001 C CNN
F 3 "" H 6050 3900 50  0001 C CNN
	2    6050 3900
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 3 1 5A777CB6
P 6050 4350
F 0 "U4" H 6200 4450 50  0000 C CNN
F 1 "74HCT04" H 6250 4250 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 4350 50  0001 C CNN
F 3 "" H 6050 4350 50  0001 C CNN
	3    6050 4350
	1    0    0    -1  
$EndComp
$Comp
L 74HCT04 U4
U 4 1 5A777D02
P 6050 4800
F 0 "U4" H 6200 4900 50  0000 C CNN
F 1 "74HCT04" H 6250 4700 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 4800 50  0001 C CNN
F 3 "" H 6050 4800 50  0001 C CNN
	4    6050 4800
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
P 6050 3350
F 0 "U4" H 6200 3450 50  0000 C CNN
F 1 "74HCT04" H 6250 3250 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6050 3350 50  0001 C CNN
F 3 "" H 6050 3350 50  0001 C CNN
	1    6050 3350
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
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 9900 3300 50  0001 C CIN
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
F 0 "C1" H 2525 3800 50  0000 L CNN
F 1 "27pf" H 2525 3600 50  0000 L CNN
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
F 1 "27pf" H 3125 3600 50  0000 L CNN
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
F 1 "10.7MHz" H 2800 3300 50  0000 C CNN
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
NoConn ~ 4700 3250
NoConn ~ 3200 2800
NoConn ~ 3200 2700
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
Entry Wire Line
	2850 950  2950 1050
Entry Wire Line
	2850 1050 2950 1150
Entry Wire Line
	2850 1150 2950 1250
Entry Wire Line
	2850 1250 2950 1350
Entry Wire Line
	2850 1350 2950 1450
Entry Wire Line
	2850 1450 2950 1550
Entry Wire Line
	2850 1550 2950 1650
Entry Wire Line
	2850 1650 2950 1750
$Comp
L 74LS138-RESCUE-TMS9918 U2
U 1 1 5A78B735
P 1250 4900
F 0 "U2" H 1350 5400 50  0000 C CNN
F 1 "74LS138" H 1400 4351 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 1250 4900 50  0001 C CNN
F 3 "" H 1250 4900 50  0001 C CNN
	1    1250 4900
	0    -1   -1   0   
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
Entry Wire Line
	3300 7100 3400 7000
Entry Wire Line
	3400 7100 3500 7000
Entry Wire Line
	3500 7100 3600 7000
Entry Wire Line
	3600 7100 3700 7000
Entry Wire Line
	3700 7100 3800 7000
Entry Wire Line
	3800 7100 3900 7000
Entry Wire Line
	3900 7100 4000 7000
Entry Wire Line
	4000 7100 4100 7000
$Comp
L C C4
U 1 1 5A79986C
P 4950 6500
F 0 "C4" H 4975 6600 50  0000 L CNN
F 1 "0.1uf" H 4975 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 4988 6350 50  0001 C CNN
F 3 "" H 4950 6500 50  0001 C CNN
	1    4950 6500
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 5A799A39
P 5250 6500
F 0 "C5" H 5275 6600 50  0000 L CNN
F 1 "0.1uf" H 5275 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5288 6350 50  0001 C CNN
F 3 "" H 5250 6500 50  0001 C CNN
	1    5250 6500
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 5A799A9F
P 5550 6500
F 0 "C6" H 5575 6600 50  0000 L CNN
F 1 "0.1uf" H 5575 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5588 6350 50  0001 C CNN
F 3 "" H 5550 6500 50  0001 C CNN
	1    5550 6500
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5A799B12
P 5850 6500
F 0 "C7" H 5875 6600 50  0000 L CNN
F 1 "0.1uf" H 5875 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 5888 6350 50  0001 C CNN
F 3 "" H 5850 6500 50  0001 C CNN
	1    5850 6500
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 5A799B88
P 6100 6500
F 0 "C8" H 6125 6600 50  0000 L CNN
F 1 "0.1uf" H 6125 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6138 6350 50  0001 C CNN
F 3 "" H 6100 6500 50  0001 C CNN
	1    6100 6500
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 5A799BEF
P 6350 6500
F 0 "C9" H 6375 6600 50  0000 L CNN
F 1 "0.1uf" H 6375 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6388 6350 50  0001 C CNN
F 3 "" H 6350 6500 50  0001 C CNN
	1    6350 6500
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR07
U 1 1 5A79A0B1
P 5850 6300
F 0 "#PWR07" H 5850 6150 50  0001 C CNN
F 1 "VCC" H 5850 6450 50  0000 C CNN
F 2 "" H 5850 6300 50  0001 C CNN
F 3 "" H 5850 6300 50  0001 C CNN
	1    5850 6300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5A79A0FD
P 5850 6700
F 0 "#PWR08" H 5850 6450 50  0001 C CNN
F 1 "GND" H 5850 6550 50  0000 C CNN
F 2 "" H 5850 6700 50  0001 C CNN
F 3 "" H 5850 6700 50  0001 C CNN
	1    5850 6700
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 5A79AE12
P 6600 6500
F 0 "C10" H 6625 6600 50  0000 L CNN
F 1 "0.1uf" H 6625 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 6638 6350 50  0001 C CNN
F 3 "" H 6600 6500 50  0001 C CNN
	1    6600 6500
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
Text Label 3300 7200 1    60   ~ 0
D0
Text Label 3400 7200 1    60   ~ 0
D1
Text Label 3500 7200 1    60   ~ 0
D2
Text Label 3600 7200 1    60   ~ 0
D3
Text Label 3700 7200 1    60   ~ 0
D4
Text Label 3800 7200 1    60   ~ 0
D5
Text Label 3900 7200 1    60   ~ 0
D6
Text Label 4000 7200 1    60   ~ 0
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
P 2400 6750
F 0 "#PWR09" H 2400 6500 50  0001 C CNN
F 1 "GND" H 2400 6600 50  0000 C CNN
F 2 "" H 2400 6750 50  0001 C CNN
F 3 "" H 2400 6750 50  0001 C CNN
	1    2400 6750
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR010
U 1 1 5A79E6FF
P 2400 7150
F 0 "#PWR010" H 2400 7000 50  0001 C CNN
F 1 "VCC" H 2400 7300 50  0000 C CNN
F 2 "" H 2400 7150 50  0001 C CNN
F 3 "" H 2400 7150 50  0001 C CNN
	1    2400 7150
	1    0    0    -1  
$EndComp
NoConn ~ 4500 7200
NoConn ~ 4400 7200
NoConn ~ 4300 7200
NoConn ~ 4200 7200
NoConn ~ 4100 7200
NoConn ~ 2900 7200
NoConn ~ 2500 7200
NoConn ~ 2700 7200
NoConn ~ 700  7200
NoConn ~ 800  7200
NoConn ~ 900  7200
NoConn ~ 1000 7200
NoConn ~ 1100 7200
Text Label 2200 7200 1    60   ~ 0
A0
Text Label 1800 7200 1    60   ~ 0
A4
Text Label 1700 7200 1    60   ~ 0
A5
Text Label 1600 7200 1    60   ~ 0
A6
Text Label 1500 7200 1    60   ~ 0
A7
Text Label 2600 7200 1    60   ~ 0
~RESET~
Text Label 2800 7200 1    60   ~ 0
~INT~
Text Label 3100 7200 1    60   ~ 0
~RD~
Text Label 3200 7200 1    60   ~ 0
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
P 5900 7300
F 0 "U4" H 6050 7400 50  0000 C CNN
F 1 "74HCT04" H 6100 7200 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 5900 7300 50  0001 C CNN
F 3 "" H 5900 7300 50  0001 C CNN
	6    5900 7300
	1    0    0    -1  
$EndComp
NoConn ~ 6350 7300
$Comp
L VCC #PWR011
U 1 1 5A7A5703
P 5450 7250
F 0 "#PWR011" H 5450 7100 50  0001 C CNN
F 1 "VCC" H 5450 7400 50  0000 C CNN
F 2 "" H 5450 7250 50  0001 C CNN
F 3 "" H 5450 7250 50  0001 C CNN
	1    5450 7250
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 4 1 5A7CFBC7
P 1950 6100
F 0 "U1" H 1950 6150 50  0000 C CNN
F 1 "74LS32" H 1950 6050 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 1950 6100 50  0001 C CNN
F 3 "" H 1950 6100 50  0001 C CNN
	4    1950 6100
	0    -1   -1   0   
$EndComp
$Comp
L 74LS32 U1
U 1 1 5A7CFD14
P 850 2700
F 0 "U1" H 850 2750 50  0000 C CNN
F 1 "74LS32" H 850 2650 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 850 2700 50  0001 C CNN
F 3 "" H 850 2700 50  0001 C CNN
	1    850  2700
	0    -1   -1   0   
$EndComp
$Comp
L 74LS32 U1
U 3 1 5A7CFDCF
P 1950 1700
F 0 "U1" H 1950 1750 50  0000 C CNN
F 1 "74LS32" H 1950 1650 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 1950 1700 50  0001 C CNN
F 3 "" H 1950 1700 50  0001 C CNN
	3    1950 1700
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 2 1 5A7CFEC8
P 1950 1200
F 0 "U1" H 1950 1250 50  0000 C CNN
F 1 "74LS32" H 1950 1150 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 1950 1200 50  0001 C CNN
F 3 "" H 1950 1200 50  0001 C CNN
	2    1950 1200
	1    0    0    -1  
$EndComp
NoConn ~ 1200 7200
NoConn ~ 1300 7200
NoConn ~ 1400 7200
Text Label 3000 7200 1    60   ~ 0
~WR~
Text Label 2100 7200 1    60   ~ 0
A1
Text Label 2000 7200 1    60   ~ 0
A2
Text Label 1900 7200 1    60   ~ 0
A3
Wire Bus Line
	550  900  2850 900 
Wire Wire Line
	2950 1050 3200 1050
Wire Wire Line
	2950 1150 3200 1150
Wire Wire Line
	2950 1250 3200 1250
Wire Wire Line
	2950 1350 3200 1350
Wire Wire Line
	2950 1450 3200 1450
Wire Wire Line
	2950 1550 3200 1550
Wire Wire Line
	2950 1650 3200 1650
Wire Wire Line
	2950 1750 3200 1750
Wire Bus Line
	2850 900  2850 1650
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
	9400 3950 9300 3950
Wire Wire Line
	8500 4600 9150 4600
Wire Wire Line
	9050 3750 9400 3750
Wire Wire Line
	9050 4500 9050 3750
Wire Wire Line
	8500 4500 9050 4500
Wire Wire Line
	8950 3650 9400 3650
Wire Wire Line
	8950 4400 8950 3650
Wire Wire Line
	8500 4400 8950 4400
Wire Wire Line
	8850 3550 9400 3550
Wire Wire Line
	8850 4300 8850 3550
Wire Wire Line
	8500 4300 8850 4300
Wire Wire Line
	8750 3450 9400 3450
Wire Wire Line
	8750 4200 8750 3450
Wire Wire Line
	8500 4200 8750 4200
Wire Wire Line
	8650 3350 9400 3350
Wire Wire Line
	8650 4100 8650 3350
Wire Wire Line
	8500 4100 8650 4100
Wire Wire Line
	8550 3250 9400 3250
Wire Wire Line
	8550 4000 8550 3250
Wire Wire Line
	8500 4000 8550 4000
Wire Wire Line
	8500 3150 9400 3150
Wire Wire Line
	8500 3050 9400 3050
Wire Wire Line
	8500 2950 9400 2950
Wire Wire Line
	8500 2850 9400 2850
Wire Wire Line
	8500 2750 9400 2750
Wire Wire Line
	8500 2650 9400 2650
Wire Wire Line
	8500 2550 9400 2550
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
Wire Wire Line
	9300 3950 9300 3850
Wire Wire Line
	9150 4600 9150 3850
Wire Wire Line
	9150 3850 9400 3850
Connection ~ 9300 3850
Connection ~ 5250 2150
Wire Wire Line
	6650 5600 6650 2050
Connection ~ 6650 5600
Wire Wire Line
	2650 2050 3200 2050
Wire Wire Line
	2550 2150 3200 2150
Wire Wire Line
	3200 2450 3050 2450
Wire Wire Line
	3050 2450 3050 2950
Wire Wire Line
	3050 2950 2300 2950
Wire Wire Line
	2300 2950 2300 6400
Wire Wire Line
	3200 2350 2950 2350
Wire Wire Line
	2950 2350 2950 2850
Wire Wire Line
	2950 2850 2350 2850
Wire Wire Line
	2350 2850 2350 6350
Wire Wire Line
	3300 7200 3300 7100
Wire Wire Line
	3400 7200 3400 7100
Wire Wire Line
	3500 7200 3500 7100
Wire Wire Line
	3600 7200 3600 7100
Wire Wire Line
	3700 7200 3700 7100
Wire Wire Line
	3800 7200 3800 7100
Wire Wire Line
	3900 7200 3900 7100
Wire Wire Line
	4000 7200 4000 7100
Wire Bus Line
	3400 7000 4750 7000
Wire Bus Line
	550  900  550  7700
Wire Wire Line
	2200 2750 2200 7200
Wire Wire Line
	2200 2750 2850 2750
Wire Wire Line
	2850 2750 2850 1950
Wire Wire Line
	2850 1950 3200 1950
Wire Wire Line
	4700 6350 6600 6350
Connection ~ 5250 6350
Connection ~ 5550 6350
Wire Wire Line
	5850 6350 5850 6300
Connection ~ 5850 6350
Connection ~ 6100 6350
Connection ~ 6350 6350
Wire Wire Line
	4700 6650 6600 6650
Connection ~ 6350 6650
Connection ~ 6100 6650
Wire Wire Line
	5850 6650 5850 6700
Connection ~ 5850 6650
Connection ~ 5550 6650
Connection ~ 5250 6650
Wire Wire Line
	5450 7300 5450 7250
Wire Bus Line
	4750 7000 4750 7700
Wire Bus Line
	4750 7700 550  7700
Wire Wire Line
	2400 7200 2400 7150
Wire Wire Line
	2400 6750 2300 6750
Wire Wire Line
	2300 6750 2300 7200
Wire Wire Line
	2300 6400 2600 6400
Wire Wire Line
	2600 6400 2600 7200
Wire Wire Line
	2350 6350 2800 6350
Wire Wire Line
	2800 6350 2800 7200
Wire Wire Line
	1600 5500 1950 5500
Wire Wire Line
	2050 6700 2100 6700
Wire Wire Line
	2100 6700 2100 7200
Wire Wire Line
	2000 7200 2000 6700
Wire Wire Line
	2000 6700 1850 6700
Wire Wire Line
	1900 7200 1900 6750
Wire Wire Line
	2550 1700 2550 2150
Wire Wire Line
	2550 1200 2650 1200
Wire Wire Line
	2650 1200 2650 2050
Wire Wire Line
	850  1100 850  2100
Wire Wire Line
	850  1600 1350 1600
Wire Wire Line
	850  1100 1350 1100
Connection ~ 850  1600
Wire Wire Line
	1350 1800 1350 3950
Wire Wire Line
	1350 3950 3100 3950
Wire Wire Line
	3100 3950 3100 7200
Wire Wire Line
	3000 7200 3000 4050
Wire Wire Line
	3000 4050 1250 4050
Wire Wire Line
	1250 4050 1250 1300
Wire Wire Line
	1250 1300 1350 1300
Wire Wire Line
	1500 7200 1500 7000
Wire Wire Line
	1500 7000 900  7000
Wire Wire Line
	900  7000 900  5500
Wire Wire Line
	1900 6750 1400 6750
Wire Wire Line
	1400 6750 1400 5500
Wire Wire Line
	1800 7200 1800 6800
Wire Wire Line
	1800 6800 1100 6800
Wire Wire Line
	1100 6800 1100 5500
Wire Wire Line
	1700 7200 1700 6850
Wire Wire Line
	1700 6850 1500 6850
Wire Wire Line
	1500 6850 1500 5500
Wire Wire Line
	1600 7200 1600 6950
Wire Wire Line
	1600 6950 1000 6950
Wire Wire Line
	1000 6950 1000 5500
Wire Wire Line
	1100 4300 1100 4250
Wire Wire Line
	1100 4250 750  4250
Wire Wire Line
	750  4250 750  3300
Wire Wire Line
	3200 7200 3200 4150
Wire Wire Line
	3200 4150 950  4150
Wire Wire Line
	950  4150 950  3300
Text Label 850  2100 1    60   ~ 0
~IORQ+ADDR~
Text Label 750  3300 3    60   ~ 0
~ADDR~
NoConn ~ 900  4300
NoConn ~ 1000 4300
NoConn ~ 1200 4300
NoConn ~ 1300 4300
NoConn ~ 1400 4300
NoConn ~ 1500 4300
NoConn ~ 1600 4300
$Comp
L C C11
U 1 1 5A7DB855
P 4700 6500
F 0 "C11" H 4725 6600 50  0000 L CNN
F 1 "0.1uf" H 4725 6400 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 4738 6350 50  0001 C CNN
F 3 "" H 4700 6500 50  0001 C CNN
	1    4700 6500
	1    0    0    -1  
$EndComp
Connection ~ 4950 6350
Connection ~ 4950 6650
$EndSCHEMATC
