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
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
<Cabbage>

;form caption("c-SID") size(1120, 800), guiMode("queue"), pluginId("CSID"), colour(0,0,255,255), typeface("C64_Pro-STYLE.ttf")
form caption("c-SID") size(1120, 800), guiMode("queue"), pluginId("CSID"), colour(0,0,32,255)
keyboard bounds(1, 702, 11199, 95) channel("keyboard") scrollbars(1) middleC(3)
image bounds(860, 4, 475, 68) channel("image10032") file("c-SIDLogo-01.png")
image bounds(772, 6, 340, 232) channel("image10030") file("1576596860commodoor64andtv.svg")
groupbox bounds(67, 235, 1041, 435) channel("groupbox10031") colour(9, 106, 106, 255) lineThickness(0) outlineColour(16, 16, 16, 255)

;Volume Related
vmeter bounds(18, 8, 35, 224) channel("vMeter1") overlayColour(0, 0, 0, 255) meterColour:0(0, 255, 0, 255) meterColour:1(0, 103, 171, 255) meterColour:2(23, 0, 123, 255) outlineColour(16, 128, 16) outlineThickness(3)
rslider bounds(4, 238, 60, 60) channel("mastervolume") range(0, 15, 15, 1, 0.001) text("Volume") valueTextBox(1) outlineColour(16, 16, 16, 255)

;Manual adjusters
groupbox bounds(304, 8, 228, 224) channel("adjustersgroup1") text("Adjusters") outlineColour(16, 16, 16, 255) outlineThickness(3)
hslider bounds(6, 36, 216, 50) channel("V1Waveform") range(0, 128, 16, 1, 16) valueTextBox(1) text("Waveform") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 0, 0, 255) colour(0, 255, 0, 255) parent("adjustersgroup1")
hslider bounds(6, 86, 216, 50) channel("V1PulseWidth") range(1, 4096, 2048, 1, 1) valueTextBox(1) text("PulseWidth") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 0, 0, 255) colour(0, 255, 0, 255) parent("adjustersgroup1")
hslider bounds(6, 136, 216, 50) channel("V1Frequency") range(1, 4096, 0, 1, 1) valueTextBox(1) text("Frequency") textColour(255, 255, 255, 255) fontColour(255, 255, 255, 255) trackerColour(0, 0, 0, 255) colour(0, 255, 0, 255) parent("adjustersgroup1")

;Envelope (ADSR)
groupbox bounds(70, 8, 227, 224) channel("envelopegroup1") text("Envelope") outlineColour(16, 16, 16, 255) outlineThickness(3)
vslider bounds(14, 30, 50, 180) channel("V1EnvAttack") range(0, 15, 0, 1, 1) text("Attack") textColour(255, 255, 255, 255) valueTextBox(1) colour(255, 255, 0, 255) trackerColour(0, 255, 255, 255) parent("envelopegroup1")
vslider bounds(64, 30, 50, 180) channel("V1EnvDecay") range(0, 15, 7, 1, 1) text("Decay") textColour(255, 255, 255, 255) valueTextBox(1) colour(255, 255, 0, 255) trackerColour(0, 255, 255, 255) parent("envelopegroup1")
vslider bounds(114, 30, 50, 180) channel("V1EnvSustain") range(1, 15, 6, 1, 1) text("Sustain") textColour(255, 255, 255, 255) valueTextBox(1) colour(255, 255, 0, 255) trackerColour(0, 255, 255, 255) parent("envelopegroup1")
vslider bounds(165, 30, 50, 180) channel("V1EnvRelease") range(0, 15, 9, 1, 1) text("Release") textColour(255, 255, 255, 255) valueTextBox(1) colour(255, 255, 0, 255) trackerColour(0, 255, 255, 255) parent("envelopegroup1")

;Display
groupbox bounds(800, 48, 134, 115) channel("waveformdisp01") text("Oscilloscope")  outlineColour(16, 128, 16, 255) outlineThickness(3) colour(0, 8, 0, 255)
signaldisplay bounds(802, 50, 131, 111), , channel("signaldisplay14"), displayType("waveform"), signalVariable ("aMix"), colour:0(0, 255, 0, 255), , zoom(0), , colour(0, 255, 0, 255)
;gentable bounds(464, 8, 331, 224)   tableNumber(16.0) fill(0) 

;Waveform Modulator GUI elements - 210 pixels apart
groupbox bounds(70, 238, 195, 430) channel("wftablegroup") text("Waveform Modulator") outlineColour(16, 16, 16, 255) outlineThickness(3)
label bounds(32, 30, 50, 10) channel("wfwavelabel") text("Wave") fontStyle("plain") parent("wftablegroup")
label bounds(80, 30, 50, 10) channel("wfamplabel") text("Amp") fontStyle("plain") parent("wftablegroup")
label bounds(130, 30, 50, 10) channel("wfwaitlabel") text("Wait") fontStyle("plain") parent("wftablegroup")
hslider bounds(16, 400, 186, 25) channel("wftableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1) trackerColour(0, 0, 0, 255) colour(255, 0, 0, 255) parent("wftablegroup")

;Pulse Width Modulator GUI elements
groupbox bounds(490, 238, 195, 430) channel("pwmtablegroup") text("Pulse Width Modulator") outlineColour(16, 16, 16, 255) outlineThickness(3)
label bounds(32, 30, 50, 10) channel("pwdutylabel") text("Width") fontStyle("plain") parent("pwmtablegroup")
label bounds(80, 30, 50, 10) channel("pwamplabel") text("Amp") fontStyle("plain") parent("pwmtablegroup")
label bounds(130, 30, 50, 10) channel("pwwaitlabel") text("Wait") fontStyle("plain") parent("pwmtablegroup")
hslider bounds(16, 400, 186, 25) channel("pwtableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1) trackerColour(0, 0, 0, 255) colour(255, 0, 0, 255) parent("pwmtablegroup")

;Frequency Modulator GUI elements
groupbox bounds(280, 238, 195, 430) channel("freqtablegroup") text("Frequency Modulator") outlineColour(16, 16, 16, 255) outlineThickness(3)
label bounds(32, 30, 50, 10) channel("freqfreqlabel") text("Freq") fontStyle("plain") parent("freqtablegroup")
label bounds(80, 30, 50, 10) channel("freqamplabel") text("Amp") fontStyle("plain") parent("freqtablegroup")
label bounds(130, 30, 50, 10) channel("freqwaitlabel") text("Wait") fontStyle("plain") parent("freqtablegroup")
hslider bounds(16, 400, 186, 25) channel("freqtableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1) trackerColour(0, 0, 0, 255) colour(255, 0, 0, 255) parent("freqtablegroup")

;Filter Table Modulator GUI elements
groupbox bounds(700, 238, 195, 430) channel("filttablegroup") text("Filter Modulator") outlineColour(16, 16, 16, 255) outlineThickness(3)
label bounds(32, 30, 50, 10) channel("filtdutylabel") text("Freq") fontStyle("plain") parent("filttablegroup")
label bounds(80, 30, 50, 10) channel("filtamplabel") text("Amp") fontStyle("plain") parent("filttablegroup")
label bounds(130, 30, 50, 10) channel("filtwaitlabel") text("Wait") fontStyle("plain") parent("filttablegroup")
hslider bounds(16, 400, 186, 25) channel("filttableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1) trackerColour(0, 0, 0, 255) colour(255, 0, 0, 255) parent("filttablegroup")

;Filter & Control Table Modulator GUI elements
groupbox bounds(910, 238, 195, 430) channel("fctltablegroup") text("Filter & Control Modulator") outlineColour(16, 16, 16, 255) outlineThickness(3)
label bounds(32, 30, 50, 10) channel("filttpyelabel") text("Type") fontStyle("plain") parent("fctltablegroup")
label bounds(80, 30, 50, 10) channel("filtReslabel") text("Reso") fontStyle("plain") parent("fctltablegroup")
label bounds(130, 30, 50, 10) channel("filtwaitlabel") text("Wait") fontStyle("plain") parent("fctltablegroup")
hslider bounds(16, 400, 186, 25) channel("fctltableselect") range(0, 31, 0, 1, 1) text("Table N.") valueTextBox(1) trackerColour(0, 0, 0, 255) colour(255, 0, 0, 255) parent("fctltablegroup")

;Control Table Modulator GUI elements
// Placeholder

label bounds(970, 52, 152, 13) channel("vanity01") text("Gavin Graham (c) 2022") align("right") fontColour(32, 32, 32, 255)

nslider bounds(428, 204, 100, 22) channel("nslider10038") range(0, 100, 0, 1, 0.01) valueTextBox(1)   colour(0, 0, 128, 8) text("Preset") textColour(66, 171, 41, 255)
combobox bounds(340, 204, 80, 20) channel("combo10039") channelType("string") value("0") 
</Cabbage>
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
<CsoundSynthesizer>
    <CsOptions>
        ;;-n --displays -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
        ;;-n -+rtmidi=NULL -M0 --displays -m0 --midi-key-cps=4 --midi-velocity-amp=5
        -n -+rtmidi=NULL -M0 --displays -m0 -+raw_controller_mode=1
        ;-n -+rtmidi=NULL -Ma --displays -m128
        ;-dm0 -n -+rtmidi=NULL -M0
    </CsOptions>
<CsInstruments>

; Initialize the global variables. 
;sr=48000
;sr is set by the host
kr=2400
ksmps = 64
nchnls = 2
0dbfs = 1

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

;					512 - 32 x the 16 row length of each table - table found by tablenum * 16
gkPWTable01[][] init 512,3
						;Absolute Val or -1 to loop|Phase/Index|Count/Delay
gkPWTable01 fillarray	1, 40, 20,
						0, 10, 10,
						0, -10, 10,
						-1, 1, 0

gkFREQTable01[][] init 512,3
gkFREQTable01 = fillarray(0, 0, 17,
						0, 0.6, 5,
						0, -0.6, 5,
						-1, 1, 0,
						0, 0, -1)
;gkFREQTable02[][] init 16,3
/*gkFREQTable02 = fillarray(0, 0, 0,
						4, 0, 0,
						7, 0, 0,
						-1, 1, 0,
						0, 0, -1)
*/						
gkWFTable01[][] init 512,3
gkWFTable01 = fillarray(16, 0, 2,
						64, 0, 10,
						-1, 1, 0,
						0, 0, -1)

gkFILTTable01[][] init 512,3
gkFILTTable01 = fillarray(0, 0, 17,
						0, 0.6, 5,
						0, -0.6, 5,
						-1, 1, 0,
						0, 0, -1)
						
gkFCTLTable01[][] init 512,3
gkFCTLTable01 = fillarray(0, 0, -1)

; - SID Control Register Waveforms
giTRI = 16
giSAW = 32
giPUL = 64
giNOI = 128

gkPresetNumber init 0
gSPresetName[] init 255
gSPresetName = fillarray("Popper Pulse", "Triangle")

/*1st index (row) is preset number and 2nd index (column) are:
	[][0]: Attack
	[][1]: Decay
	[][2]: Sustain
	[][3]: Release
	[][8]: Table# Waveform Modulator
	[][9]: Table# Frequency Modulator
	[][10]: Table# Pulse Width Modulator
	[][11]: Table# Filter Modulator
	[][12]: Table# Filter Control Modulator
	*/	
gkPresetConfig[][] init 255,32
gkPresetConfig = fillarray(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)


;massign 0,2
;maxalloc 3,1

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;instr    2                                ; RESPOND TO MIDI NOTES
;	icps = cpsmidi()
;	inum = notnum()
;	givel = veloc(0,1)
;	gkVel init givel
;	gkcps = icps
;	gicps init icps
;    event_i "i",3,0,-1, icps, inum
;    printk2 inum
;    ;printk2 gkVel
;	gkNewNote init 1
;endin

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;instrument will be triggered by keyboard widget or MIDI event
instr SYNTH
	aOut init 0
	aMix init 0
	aTRI init 0
	aSAW init 0
	aPUL init 0
	aNOI init 0
	kmasterVolume init 1
	
	; the K rate is set to 2400 so this needs to be krate / 60hz = 40
	kSIDDivider init 40
	kSIDDividerCounter init 1
	
	; Pulse Width Modulator
	kPWTableIndex init -1
	kPWIndexOld init 0
	kPWDelayCounter init 0
	kPWPhaseIndex init 0
	kPulseWidth init 0
	kPWRepeatCounter init 0
	
	; Frequency Modulator
	kFREQTableIndex init -1
	kFREQIndexOld init 0
	kFREQDelayCounter init 0
	kFREWRepeatCounter init 0
	kNote init 0
	kFREQ init 0
	
	; Waveform Modulator
	kWFTableIndex init -1
	kWFIndexOld init 0
	kWFDelayCounter init 0
	kWFRepeatCounter init 0
	kWF init 0
	
	; Frequency Modulator
	kFILTTableIndex init -1
	kFILTIndexOld init 0
	kFILTDelayCounter init 0
	kFILTAmpIndex init 0
	kFilterFreq init 0
	kFILTRepeatCounter init 0
	
	; Filter Control Modulator
	kFCTableIndex init -1
	kFCIndexOld init 0
	kFCDelayCounter init 0
	kFCRepeatCounter init 0
	;kFC init 0
	kFCFiltType init 0
	kFCResonance init 0

	kWaveformchanged init 0   
  
	;iNoteFrequency = p4
	;iMidiVelocity = p5
	iMidiNote = notnum()
	iNoteFRQ = mtof:i(iMidiNote)
	iRawMidiVelocity = veloc:i(0, 127)
	kNoteRelease = release()  
    
	iADSRAttack = cabbageGetValue:i("V1EnvAttack")
	iADSRDecay = cabbageGetValue:i("V1EnvDecay")
	iADSRSustain = cabbageGetValue:i("V1EnvSustain")
	iADSRRelease = cabbageGetValue:i("V1EnvRelease")
    
	;Debug Stuffs
	;kWaveform cabbageGetValue "V1Waveform"
	;kWaveformchanged changed kWaveform	
	;kPulseWidth cabbageGetValue "V1PulseWidth"
	;printk2 kNoteRelease
	/*
	kstatus, kchan, kdata1, kdata2  midiin            ;read in midi
	ktrigger changed kstatus, kchan, kdata1, kdata2 ;trigger if midi data change
 	if ktrigger=1 && kstatus!=0 then          ;if status byte is non-zero...
		; -- print midi data to the terminal with formatting --
 		printks "status:%d%tchannel:%d%tdata1:%d%tdata2:%d%n",0,kstatus,kchan,kdata1,kdata2
 	endif
	*/
	kSIDDividerCounter -= 1
	if kSIDDividerCounter == 0 then
		kSIDDividerCounter = kSIDDivider
		
		; Pulse Width Modulator
		if kPWDelayCounter != -1 then
			kPWIndexOld = kPWTableIndex
			kTabNum = gkPresetConfig[gkPresetNumber][10]*16
			kPWDelayCounter -= 1
			if kPWDelayCounter < 0 then
				kPWTableIndex += 1
				if gkPWTable01[kTabNum+kPWTableIndex][0] = -1 then
					kPWTableIndex = gkPWTable01[kTabNum+kPWTableIndex][1]
				endif
				kPWDelayCounter = gkPWTable01[kTabNum+kPWTableIndex][2]
				kPWPhaseIndex = gkPWTable01[kTabNum+kPWTableIndex][1]
				if gkPWTable01[kTabNum+kPWTableIndex][0] > 0 then
					kPulseWidth = gkPWTable01[kTabNum+kPWTableIndex][0]
				endif
			else
				kPulseWidth += gkPWTable01[kTabNum+kPWTableIndex][1]
			endif
			if kPWIndexOld != kPWTableIndex then
				SWidgetChannel = sprintfk("pwdatarow%d", kPWIndexOld)
    			cabbageSet(1, SWidgetChannel, "colour", 64, 64, 46, 128)
    		endif
			SWidgetChannel = sprintfk("pwdatarow%d", kPWTableIndex)
    		cabbageSet(1, SWidgetChannel, "colour", 255, 255, 255, 64)
		endif
	
		; Note & Frequency Modulator
		if kFREQDelayCounter != -1 then
			kFREQIndexOld = kFREQTableIndex
			kTabNum = gkPresetConfig[gkPresetNumber][10]*16
			kFREQDelayCounter -= 1
			if kFREQDelayCounter < 0 then
				kFREQTableIndex += 1
				if gkFREQTable01[kTabNum+kFREQTableIndex][0] = -1 then
					kFREQTableIndex = gkFREQTable01[kTabNum+kFREQTableIndex][1]
				endif
				kFREQDelayCounter = gkFREQTable01[kTabNum+kFREQTableIndex][2]
				kNote = iMidiNote + gkFREQTable01[kTabNum+kFREQTableIndex][0]
				kFREQ = mtof(kNote)
			endif
			kFREQ += gkFREQTable01[kTabNum+kFREQTableIndex][1]
			if kFREQIndexOld != kFREQTableIndex then
				SWidgetChannel = sprintfk("freqdatarow%d", kFREQIndexOld)
    			cabbageSet(1, SWidgetChannel, "colour", 64, 64, 46, 128)
    		endif
				SWidgetChannel = sprintfk("freqdatarow%d", kFREQTableIndex)
    			cabbageSet(1, SWidgetChannel, "colour", 255, 255, 255, 64)
			endif
	
			; Waveform Modulator
			if kWFDelayCounter != -1 then
				kWFIndexOld = kWFTableIndex
				kTabNum = gkPresetConfig[gkPresetNumber][8]*16  
				kWFDelayCounter -= 1
				if kWFDelayCounter < 0 then
					kWFTableIndex += 1
					if gkWFTable01[kTabNum+kWFTableIndex][0] = -1 then
						kWFTableIndex = gkWFTable01[kTabNum+kWFTableIndex][1]
					endif
					kWFDelayCounter = gkWFTable01[kTabNum+kWFTableIndex][2]
					kWaveform = gkWFTable01[kTabNum+kWFTableIndex][0]
					if kWFIndexOld != kWFTableIndex then
						SWidgetChannel = sprintfk("wfdatarow%d", kWFIndexOld)
    					cabbageSet(1, SWidgetChannel, "colour", 64, 64, 46, 128)
    				endif
					SWidgetChannel = sprintfk("wfdatarow%d", kWFTableIndex)
    				cabbageSet(1, SWidgetChannel, "colour", 255, 255, 255, 64)
				endif
			endif
	
			; Filter Modulator
			if kFILTDelayCounter != -1 then
				kFILTIndexOld = kFILTTableIndex
				kTabNum = gkPresetConfig[gkPresetNumber][11]*16
				kFILTDelayCounter -= 1
				if kFILTDelayCounter < 0 then
					kFILTTableIndex += 1
					if gkFILTTable01[kTabNum+kFILTTableIndex][0] = -1 then
						kFILTTableIndex = gkFILTTable01[kTabNum+kFILTTableIndex][1]
					endif
					kFILTDelayCounter = gkFILTTable01[kTabNum+kFILTTableIndex][2]
					kFILTAmpIndex = gkFILTTable01[kTabNum+kFILTTableIndex][1]
					if gkFILTTable01[kTabNum+kFILTTableIndex][0] > 0 then
						kFilterFreq = gkFILTTable01[kTabNum+kFILTTableIndex][0]
					endif
				else
					kFilterFreq += gkFILTTable01[kTabNum+kFILTTableIndex][1]
				endif
				if kFILTIndexOld != kFILTTableIndex then
					SWidgetChannel = sprintfk("filtdatarow%d", kFILTIndexOld)
    				cabbageSet(1, SWidgetChannel, "colour", 64, 64, 46, 128)
    			endif
				SWidgetChannel = sprintfk("filtdatarow%d", kFILTTableIndex)
    			cabbageSet(1, SWidgetChannel, "colour", 255, 255, 255, 64)
			endif
	
			; Filter & Control Modulator
			if kFCDelayCounter != -1 then
				kFCIndexOld = kFCTableIndex
				kTabNum = gkPresetConfig[gkPresetNumber][12]*16  
				kFCDelayCounter -= 1
				if kFCDelayCounter < 0 then
					kFCTableIndex += 1
					if gkFCTLTable01[kTabNum+kFCTableIndex][0] = -1 then
						kFCTableIndex = gkFCTLTable01[kTabNum+kFCTableIndex][1]
					endif
					kWFDelayCounter = gkFCTLTable01[kTabNum+kFCTableIndex][2]
					kFCFiltType = gkFCTLTable01[kTabNum+kFCTableIndex][0]
					kFCResonance = gkFCTLTable01[kTabNum+kFCTableIndex][1]
					if kWFIndexOld != kWFTableIndex then
						SWidgetChannel = sprintfk("fctldatarow%d", kFCIndexOld)
    					cabbageSet(1, SWidgetChannel, "colour", 64, 64, 46, 128)
    				endif
					SWidgetChannel = sprintfk("fctldatarow%d", kFCTableIndex)
    				cabbageSet(1, SWidgetChannel, "colour", 255, 255, 255, 64)
				endif
			endif
	endif
	
;---Oscillator Section
	if (kWaveform & giTRI) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth - Should be Triangle but I'm working on it.
		;aTRI = oscil(iRawMidiVelocity/127, kFREQ, giTRI)
		aTRI = vco2(iRawMidiVelocity/127, kFREQ, 12, kPulseWidth/4096)
	else
		aTRI = 1
	endif
    
	if (kWaveform & giSAW) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
		;aSAW oscil iRawMidiVelocity/127, iNoteFRQ, giSAW
		aSAW = vco2(iRawMidiVelocity/127, kFREQ, 0, kPulseWidth/4096)
	else
    	aSAW = 1
	endif
    
	if (kWaveform & giPUL) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
		;aPUL oscil iRawMidiVelocity/127, iNoteFRQ, giPUL
		aPUL = vco2(iRawMidiVelocity/127, kFREQ, 2, kPulseWidth/4096)
    else
    	aPUL = 1
	endif
    
	if (kWaveform & giNOI) != 0 then
		;aOut vco2 iMidiVelocity, iNoteFrequency ; Sawtooth
		aNOI = randh(iRawMidiVelocity/127, kFREQ)
    else
    	aNOI = 1
	endif
    ;Combine all possible waveforms
	aOut = 1 - sum(aTRI, aSAW, aPUL, aNOI) / 4
	;Apply Filter
	;aOut = moogladder(aOut, kFilterFreq, 0.9)
	;Apply ADSR
	kEnv = madsr(giEnvAttack[iADSRAttack], giEnvDecayRelease[iADSRDecay], iADSRSustain/15, giEnvDecayRelease[iADSRRelease])

	;Mix the master volume
	kmasterVolume = cabbageGetValue("mastervolume")
	kmasterVolume = kmasterVolume / 15
	;Final master volume mix
	aMix = aOut * kEnv * kmasterVolume
	;Finaly output the damn thing!
	outs(aMix, aMix)
    ;Oh, yeah some more display - maybe all the fast GUI updates should move here
	display(aMix, .01, 2)
	
;---GUI Section    
	/*
	if kWaveformchanged == 1 then
		cabbageSet  "gentable1", "tableNumber", kWaveform
		printk2 kWaveform
	endif
	*/
	cabbageSetValue("V1Frequency", kFREQ)
	cabbageSetValue("V1Waveform", kWaveform, changed:k(kWaveform))
	cabbageSetValue("V1PulseWidth", kPulseWidth, changed(kPulseWidth))
	cabbageSetValue("vMeter1", kEnv, changed(kEnv))

endin
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
instr GUI
	; Set-up Pulse Width Modulation GUI Elements
	; Three separate bold with each colum separate as colums may have a range of limits and increments specific to it.	
    iY init 0
    while iY < 16 do
    	SWidget = sprintf("bounds(%d, %d, 16, 12), channel(\"pwdatarow%d\"), text(\"%d\") fontStyle(\"plain\") align(\"right\") parent(\"pwmtablegroup\") colour(64,64,64,128)", 12, 48+iY*22, iY, iY)
    	cabbageCreate("label", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"pwdataentry%d-0\"), range(-1,4095,0,1,1), colour(128, 128, 128, 8) parent(\"pwmtablegroup\")", -18+1*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"pwdataentry%d-1\"), range(-16384,16383,0,1,1), colour(28, 128, 128, 8) parent(\"pwmtablegroup\")", -18+2*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"pwdataentry%d-2\"), range(-1,16384,0,1,1), colour(28, 128, 128, 8) parent(\"pwmtablegroup\")", -18+3*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		iY += 1
	od
	
	; Set-up Frequency Modulation GUI elements
    iY init 0
    while iY < 16 do
    	SWidget = sprintf("bounds(%d, %d, 16, 12), channel(\"freqdatarow%d\"), text(\"%d\") fontStyle(\"plain\") align(\"right\") parent(\"freqtablegroup\") colour(64,64,64,128)", 12, 48+iY*22, iY, iY)
    	cabbageCreate("label", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"freqdataentry%d-0\"), range(-1,65535,0,1,1), colour(28, 128, 128, 8) parent(\"freqtablegroup\")", -18+1*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"freqdataentry%d-1\"), range(-16384,16383,0,1,1), colour(28, 128, 128, 8) parent(\"freqtablegroup\")", -18+2*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"freqdataentry%d-2\"), range(-1,16384,0,1,1), colour(28, 128, 128, 8) parent(\"freqtablegroup\")", -18+3*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		iY += 1
	od
	
	; Set-up Waveform Modulation GUI elements
    iY init 0
    while iY < 16 do
    	SWidget = sprintf("bounds(%d, %d, 16, 12), channel(\"wfdatarow%d\"), text(\"%d\") fontStyle(\"plain\") align(\"right\") parent(\"wftablegroup\") colour(64,64,64,128)", 12, 48+iY*22, iY, iY)
    	cabbageCreate("label", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"wfdataentry%d-0\"), range(-1,65535,0,1,1), colour(28, 128, 128, 8) parent(\"wftablegroup\")", -18+1*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"wfdataentry%d-1\"), range(-16384,16383,0,1,1), colour(28, 128, 128, 8) parent(\"wftablegroup\")", -18+2*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"wfdataentry%d-2\"), range(-1,16384,0,1,1), colour(28, 128, 128, 8) parent(\"wftablegroup\")", -18+3*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		iY += 1
	od
	
	; Set-up Filter Modulation GUI elements
    iY init 0
    while iY < 16 do
    	SWidget = sprintf("bounds(%d, %d, 16, 12), channel(\"filtdatarow%d\"), text(\"%d\") fontStyle(\"plain\") align(\"right\") parent(\"filttablegroup\") colour(64,64,64,128)", 12, 48+iY*22, iY, iY)
    	cabbageCreate("label", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"filtdataentry%d-0\"), range(-1,65535,0,1,1), colour(28, 128, 128, 8) parent(\"filttablegroup\")", -18+1*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"filtdataentry%d-1\"), range(-16384,16383,0,1,1), colour(28, 128, 128, 8) parent(\"filttablegroup\")", -18+2*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"filtdataentry%d-2\"), range(-1,16384,0,1,1), colour(28, 128, 128, 8) parent(\"filttablegroup\")", -18+3*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		iY += 1
	od
	
	; Set-up Filter and Control Modulation GUI elements
    iY init 0
    while iY < 16 do
    	SWidget = sprintf("bounds(%d, %d, 16, 12), channel(\"fctldatarow%d\"), text(\"%d\") fontStyle(\"plain\") align(\"right\") parent(\"fctltablegroup\") colour(64,64,64,128)", 12, 48+iY*22, iY, iY)
    	cabbageCreate("label", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"fctldataentry%d-0\"), range(-1,65535,0,1,1), colour(28, 128, 128, 8) parent(\"fctltablegroup\")", -18+1*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"fctldataentry%d-1\"), range(-16384,16383,0,1,1), colour(28, 128, 128, 8) parent(\"fctltablegroup\")", -18+2*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		SWidget = sprintf("bounds(%d, %d, 50, 22), channel(\"fctldataentry%d-2\"), range(-1,16384,0,1,1), colour(28, 128, 128, 8) parent(\"fctltablegroup\")", -18+3*50, 42+iY*22, iY)
		cabbageCreate("nslider", SWidget)
		iY += 1
	od
	
	; Populate the widgets from the table arrays.
	iY init 0
	while iY < 16 do
		iX init 0
		while iX < 3 do
			kTabNum = gkPresetConfig[gkPresetNumber][10]*16
			SWidgetChannel = sprintf("pwdataentry%d-%d", iY, iX)
			cabbageSetValue(SWidgetChannel, i(gkPWTable01,i(kTabNum)+iY,iX))
			
			kTabNum = gkPresetConfig[gkPresetNumber][9]*16
			SWidgetChannel = sprintf("freqdataentry%d-%d", iY, iX)
			cabbageSetValue(SWidgetChannel, i(gkFREQTable01,i(kTabNum)+iY,iX))
			
			kTabNum = gkPresetConfig[gkPresetNumber][8]*16
			SWidgetChannel = sprintf("wfdataentry%d-%d", iY, iX)
			cabbageSetValue(SWidgetChannel, i(gkWFTable01,i(kTabNum)+iY,iX))
			
			kTabNum = gkPresetConfig[gkPresetNumber][11]*16
			SWidgetChannel = sprintf("filtdataentry%d-%d", iY, iX)
			cabbageSetValue(SWidgetChannel, i(gkFILTTable01,i(kTabNum)+iY,iX))
			
			kTabNum = gkPresetConfig[gkPresetNumber][12]*16
			SWidgetChannel = sprintf("fctldataentry%d-%d", iY, iX)
			cabbageSetValue(SWidgetChannel, i(gkFCTLTable01,i(kTabNum)+iY,iX))
			
			iX += 1
		od
       	iY += 1
	od
	
	; Runtime updating of the tables from the widgets.
    if metro(2) == 1 then
		kY = 0
    	while kY < 16 do
    		kX = 0
    		while kX < 3 do
    			SWidgetChannel = sprintfk("pwdataentry%d-%d", kY, kX)
				if changed(cabbageGetValue(SWidgetChannel)) != 0 then
					kTabNum = gkPresetConfig[gkPresetNumber][10]*16
    				gkPWTable01[kTabNum+kY][kX] = cabbageGetValue(SWidgetChannel)
				endif
				
				SWidgetChannel = sprintfk("freqdataentry%d-%d", kY, kX)
				if changed(cabbageGetValue(SWidgetChannel)) != 0 then
					kTabNum = gkPresetConfig[gkPresetNumber][9]*16
    				gkFREQTable01[kTabNum+kY][kX] = cabbageGetValue(SWidgetChannel)
				endif
				
				SWidgetChannel = sprintfk("wfdataentry%d-%d", kY, kX)
				if changed(cabbageGetValue(SWidgetChannel)) != 0 then
					kTabNum = gkPresetConfig[gkPresetNumber][8]*16
    				gkWFTable01[kTabNum+kY][kX] = cabbageGetValue(SWidgetChannel)
				endif
				
				SWidgetChannel = sprintfk("filtdataentry%d-%d", kY, kX)
				if changed(cabbageGetValue(SWidgetChannel)) != 0 then
					kTabNum = gkPresetConfig[gkPresetNumber][11]*16
    				gkFILTTable01[kTabNum+kY][kX] = cabbageGetValue(SWidgetChannel)
				endif
				
				SWidgetChannel = sprintfk("fctldataentry%d-%d", kY, kX)
				if changed(cabbageGetValue(SWidgetChannel)) != 0 then
					kTabNum = gkPresetConfig[gkPresetNumber][12]*16
    				gkFCTLTable01[kTabNum+kY][kX] = cabbageGetValue(SWidgetChannel)
				endif
				
				kX += 1
			od
        	kY += 1
    	od   
    	kY = 0
    endif
endin

</CsInstruments>
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
<CsScore>

;Waveform function tables
f 16    0   512     7   -1 256 1 256 -1 ;Triangle (0x10)
f 32 	0 	512 	7 	-1 512 1 ;Sawtooth (0x20)
f 64 	0 	1024 	7 	1 512 1 0 -1 512 -1 ;Square (0x40)

;causes Csound to run for about 7000 years...
i"GUI" 0 z
;f0 z
</CsScore>

</CsoundSynthesizer>
