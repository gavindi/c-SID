//  ---------------------------------------------------------------------------
//  This file is part of c-SID, a MOS6581 SID music routine as a VST.
//  Copyright (C) 2022  Gavin Graham <gavindi@gmail.com>
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2 as published by
//  the Free Software Foundation.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//  ---------------------------------------------------------------------------

<Cabbage>
bounds(0, 0, 0, 0)

;form caption("c-SID") size(800, 800), guiMode("queue"), pluginId("CSID"), colour(0,0,255,255), typeface("C64_Pro-STYLE.ttf")
form caption("c-SID") size(800, 800), guiMode("queue"), pluginId("CSID"), colour(0,0,0,255)
keyboard bounds(2, 702, 798, 95) channel("keyboard")

;Volume Related
vmeter bounds(18, 6, 35, 220) channel("vMeter1")  overlayColour(0, 0, 0, 255) meterColour:0(0, 255, 0, 255) meterColour:1(0, 103, 171, 255) meterColour:2(23, 0, 123, 255)
rslider bounds(4, 230, 60, 60) channel("rslider10015") range(0, 1, 0, 1, 0.001) text("Volume") valueTextBox(1)

;Manual adjusters
groupbox bounds(304, 8, 228, 185) channel("groupbox10016") text("Adjusters")
hslider bounds(310, 34, 216, 50) channel("V1Waveform") range(0, 128, 16, 1, 16) valueTextBox(1) text("Waveform") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 255, 255, 255) colour(0, 255, 0, 255)
hslider bounds(310, 84, 216, 50) channel("V1PulseWidth") range(1, 4096, 2048, 1, 1) valueTextBox(1) text("PulseWidth") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 255, 255, 255) colour(0, 255, 0, 255)
hslider bounds(310, 134, 216, 50) channel("V1Frequency") range(1, 4096, 0, 1, 1) valueTextBox(1) text("Frequency") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 255, 255, 255) colour(0, 255, 0, 255)

groupbox bounds(70, 6, 227, 187) channel("groupbox10006") text("Envelope")
vslider bounds(84, 36, 50, 150) channel("V1EnvAttack") range(0, 15, 0, 1, 1) text("Attack") textColour(255, 255, 255, 255) valueTextBox(1) colour(0, 255, 0, 255) trackerColour(0, 255, 255, 255)
vslider bounds(132, 36, 50, 150) channel("V1EnvDecay") range(0, 15, 7, 1, 1) text("Decay") textColour(255, 255, 255, 255) valueTextBox(1) colour(0, 255, 0, 255) trackerColour(0, 255, 255, 255)
vslider bounds(182, 36, 50, 150) channel("V1EnvSustain") range(1, 15, 6, 1, 1) text("Sustain") textColour(255, 255, 255, 255) valueTextBox(1) colour(0, 255, 0, 255) trackerColour(0, 255, 255, 255)
vslider bounds(232, 36, 50, 150) channel("V1EnvRelease") range(0, 15, 9, 1, 1) text("Release") textColour(255, 255, 255, 255) valueTextBox(1) colour(0, 255, 0, 255) trackerColour(0, 255, 255, 255)

;Display
groupbox bounds(540, 8, 252, 224) channel("groupbox10007") text("Output")
signaldisplay bounds(552, 32, 229, 187), , colour(0, 255, 0, 255), channel("signaldisplay14"), displayType("waveform"), signalVariable("aMix"), colour:0(0, 255, 0, 255), , zoom(3), 
;gentable bounds(464, 8, 331, 224)   tableNumber(16.0) fill(0) 

;Pulse Width Modulator GUI elements
groupbox bounds(78, 238, 195, 430) channel("pwmtablegroup") text("Pulse Width Modulator")
label bounds(110, 264, 50, 16) channel("pwdutylabel") text("Width") fontStyle("plain")
label bounds(160, 264, 50, 16) channel("pwamplabel") text("Amp") fontStyle("plain")
label bounds(210, 264, 50, 16) channel("pwwaitlabel") text("Wait") fontStyle("plain")
hslider bounds(86, 640, 186, 25) channel("pwtableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1)

label bounds(644, 684, 152, 13) channel("vanity01") text("Gavin Graham (c) 2020") fontStyle("plain")
</Cabbage>
//  ---------------------------------------------------------------------------
<CsoundSynthesizer>
    <CsOptions>
        ;-n --displays -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
        ;-n -+rtmidi=NULL -M0 --displays -m0 --midi-key-cps=4 --midi-velocity-amp=5
        -n -+rtmidi=NULL -M0 --displays -m0 -+raw_controller_mode=1
    </CsOptions>
<CsInstruments>

; Initialize the global variables. 
;sr=48000
;sr is set by the host
kr=30
ksmps = 32
nchnls = 2
0dbfs = 0.75

/* Conversion tables from SID 0 to F values to seconds for CSound's 'madsr' opcode

  	 	Attack Rate	    Release Rate
DEC	HEX	(Time/Cycle)	(Time/Cycle)
0	(0)	2 mS	        6 mS
1	(1)	8 mS	        24 mS
2	(2)	16 mS	        48 mS
3	(3)	24 mS	        72 mS
4	(4)	38 mS	        114 mS
5	(5)	56 mS	        168 mS
6	(6)	68 mS	        204 mS
7	(7)	80 mS	        240 mS
8	(8)	100 mS	        300 mS
9	(9)	250 mS	        750 mS
10	(A)	500 mS	        1.5 S
11	(B)	800 mS	        2.4 S
12	(C)	1 S	            3 S
13	(D)	3 S	            9 S
14	(E)	5 S	            15 S
15	(F)	8 S	            24 S
*/
giEnvAttack[] fillarray 0.002, 0.008, 0.016, 0.024, 0.038, 0.056, 0.068, 0.080, 0.1, 0.25, 0.5, 0.8, 1, 3, 5, 8
giEnvDecayRelease[] fillarray 0.006, 0.024, 0.048, 0.072, 0.114, 0.168, 0.204, 0.24, 0.3, 0.75, 1.5, 2.4, 3, 9, 15, 24

						
gkPWTable01[][] init 16,3
						;Absolute Val or -1 to loop|Phase/Index|Count/Delay
gkPWTable01 fillarray	1, 40, 20,
						0, 10, 10,
						0, -10, 10,
						-1, 1, 0

gkFREQTable01[][] init 16,3
gkFREQTable02[][] init 16,3
gkFREQTable01 fillarray	0, 0, 17,
						0, 0.6, 2,
						0, -0.6, 2,
						-1, 1, 0,
						0, 0, -1
gkFREQTable02 fillarray	0, 0, 0,
						4, 0, 0,
						7, 0, 0,
						-1, 1, 0,
						0, 0, -1
						
gkWFTable01[][] init 16,3
gkWFTable01 fillarray	16, 0, 2,
						64, 0, 10,
						-1, 1, 0,
						0, 0, -1

; - SID Control Register Waveforms
giTRI = 16
giSAW = 32
giPUL = 64
giNOI = 128

;instrument will be triggered by keyboard widget or MIDI event
instr 1
	aOut init 0
	aMix init 0
	aTRI init 0
	aSAW init 0
	aPUL init 0
	aNOI init 0
	
	; Pulse Width Modulator
	kPWTableIndex init -1
	kPWDelayCounter init 0
	kPWPhaseIndex init 0
	kPulseWidth init 0
	
	; Frequency Modulator
	kFREQTableIndex init -1
	kFREQDelayCounter init 0
	kNote init 0
	kFREQ init 0
	
	; Waveform Modulator
	kWFTableIndex init -1
	kWFDelayCounter init 0
	kWF init 0
 
	kWaveformchanged init 0   
  
	;iNoteFrequency = p4
	;iMidiVelocity = p5
	iMidiNote notnum
	iNoteFRQ mtof iMidiNote
	iRawMidiVelocity veloc 0, 127
	kNoteRelease release  
    
	iADSRAttack cabbageGetValue "V1EnvAttack"
	iADSRDecay cabbageGetValue "V1EnvDecay"
	iADSRSustain cabbageGetValue "V1EnvSustain"
	iADSRRelease cabbageGetValue "V1EnvRelease"
    
	;kWaveform cabbageGetValue "V1Waveform"
	;kWaveformchanged changed kWaveform
	
	;kPulseWidth cabbageGetValue "V1PulseWidth"
	printk2 kNoteRelease
	
	; Pulse Width Modulator
	if kPWDelayCounter != -1 then
		kPWDelayCounter = kPWDelayCounter - 1
		if kPWDelayCounter < 0 then
			kPWTableIndex = kPWTableIndex + 1
			if gkPWTable01[kPWTableIndex][0] = -1 then
				kPWTableIndex = gkPWTable01[kPWTableIndex][1]
			endif
			kPWDelayCounter = gkPWTable01[kPWTableIndex][2]
			kPWPhaseIndex = gkPWTable01[kPWTableIndex][1]
			if gkPWTable01[kPWTableIndex][0] > 0 then
				kPulseWidth = gkPWTable01[kPWTableIndex][0]
			endif
		else
			kPulseWidth = kPulseWidth + gkPWTable01[kPWTableIndex][1]
		endif
	endif
	
	; Note & Frequency Modulator
	if kFREQDelayCounter != -1 then
		kFREQDelayCounter = kFREQDelayCounter - 1
		if kFREQDelayCounter < 0 then
			kFREQTableIndex = kFREQTableIndex + 1
			if gkFREQTable01[kFREQTableIndex][0] = -1 then
				kFREQTableIndex = gkFREQTable01[kFREQTableIndex][1]
			endif
			kFREQDelayCounter = gkFREQTable01[kFREQTableIndex][2]
			kNote = iMidiNote + gkFREQTable01[kFREQTableIndex][0]
			kFREQ mtof kNote
		endif
		kFREQ = kFREQ + gkFREQTable01[kFREQTableIndex][1]
	endif
	
	; Waveform Modulator
	if kWFDelayCounter != -1 then
		kWFDelayCounter = kWFDelayCounter -1
		if kWFDelayCounter < 0 then
			kWFTableIndex = kWFTableIndex +1
			if gkWFTable01[kWFTableIndex][0] = -1 then
				kWFTableIndex = gkWFTable01[kWFTableIndex][1]
			endif
			kWFDelayCounter = gkWFTable01[kWFTableIndex][2]
			kWaveform = gkWFTable01[kWFTableIndex][0]
		endif
	endif

	if (kWaveform & giTRI) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth - Should be Triangle but I'm working on it.
		aTRI oscil iRawMidiVelocity/127, kFREQ, giTRI
	else
		aTRI = 0
	endif
    
	if (kWaveform & giSAW) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
		;aSAW oscil iRawMidiVelocity/127, iNoteFRQ, giSAW
		aSAW vco2 iRawMidiVelocity/127, kFREQ, 0, kPulseWidth/4096
	else
    	aSAW = 0
	endif
    
	if (kWaveform & giPUL) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
		;aPUL oscil iRawMidiVelocity/127, iNoteFRQ, giPUL
		aPUL vco2 iRawMidiVelocity/127, kFREQ, 2, kPulseWidth/4096
    else
    	aPUL = 0
	endif
    
	if (kWaveform & giNOI) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
	aNOI randh iRawMidiVelocity/127, kFREQ
    else
    	aNOI = 0
	endif
    
	aOut sum aTRI, aSAW, aPUL, aNOI 
	kEnv madsr giEnvAttack[iADSRAttack], giEnvDecayRelease[iADSRDecay], iADSRSustain/15, giEnvDecayRelease[iADSRRelease]
	aMix = aOut*kEnv
	outs aMix, aMix
    
	display	aMix, .01, 2
    
	;if kWaveformchanged == 1 then
		;cabbageSet  "gentable1", "tableNumber", kWaveform
		;printk2 kWaveform
	;endif
	
	cabbageSetValue "V1Frequency", kFREQ

	kPulseWidthchanged changed kPulseWidth
	if kPulseWidthchanged == 1 then
		cabbageSetValue "V1PulseWidth", kPulseWidth
	endif

	kEnvChanged changed kEnv
	if kEnvChanged == 1 then
		cabbageSetValue "vMeter1", kEnv
	endif 
    /*
	kstatus, kchan, kdata1, kdata2  midiin              ;read in midi
	ktrigger changed kstatus, kchan, kdata1, kdata2     ;trigger if midi data change
	if ktrigger = 1 && kstatus != 0 then                ;if status byte is non-zero...
    	; -- print midi data to the terminal with formatting --
		printks "status:%d%tchannel:%d%tdata1:%d%tdata2:%d%n", 0, kstatus, kchan, kdata1, kdata2
	endif
	*/
endin

instr 2
	; Set-up Pulse Width Modulation GUI Elements
	iXPos = 90
	iYPos = 280
  
    iX, iY init 0
    while iY < 16 do
    	SWidget sprintf "bounds(%d, %d, 50, 16), channel(\"pwrowlbl%d\"), text(\"%d: \") fontStyle(\"plain\") align(\"right\")", iXPos-30, iYPos+iY*22, iY, iY
    	cabbageCreate "label", SWidget
        while iX < 3 do
            SWidget sprintf "bounds(%d, %d, 50, 22), channel(\"pwdataentry%d-%d\"), range(0,100,0,1,1)", iXPos+20+iX*50, iYPos+iY*22, iY, iX
            cabbageCreate "nslider", SWidget
            SWidgetChannel sprintfk "pwdataentry%d-%d", iY, iX
            cabbageSetValue SWidgetChannel, gkPWTable01[iY][iX]
            iX += 1
        od
        iX = 0
        iY += 1
    od

    if metro(3) == 1 then
        ;kOnOff  = random:k(0, 100)
        ;kBox = random:k(0, 47)
        ;SWidgetChannel sprintfk "pwdataentry%d", kBox
        ;cabbageSetValue SWidgetChannel, kOnOff
        ;event "i", "Synth", 0, 2, int(kBox), kOnOff
    endif
endin

</CsInstruments>
//  ---------------------------------------------------------------------------
<CsScore>

;Waveform function tables
f 16    0   512     7   -1 256 1 256 -1 ;Triangle (0x10)
f 32 	0 	512 	7 	-1 512 1 ;Sawtooth (0x20)
f 64 	0 	1024 	7 	1 512 1 0 -1 512 -1 ;Square (0x40)

;causes Csound to run for about 7000 years...
i2 0 z
f0 z
</CsScore>

</CsoundSynthesizer>
