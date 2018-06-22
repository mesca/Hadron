<CsoundSynthesizer>
<CsInstruments>
sr      = 44100
ksmps  	= 16
nchnls 	= 2

opcode reeverb, aa, aa
	ainL, ainR xin

	iCombDelTab_1L ftgen 0,0,64,-2,-1009,-1103,-1123,-1281,-1289,-1307,-1361,-1409,-1429,-1543,-1583,-1601,-1613,-1709,-1801,-1949,-2003,-2111,-2203,-2341,-2411,-2591,-2609,-2749,-2801,-2903,-3001,-3109,-3203,-3301,-3407,-3539,0.82,0.81,0.8,0.79,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,0.7,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62,0.61,0.6,0.59,0.58,0.57,0.56,0.55,0.54,0.53,0.52,0.51
	iCombDelTab_1R ftgen 0,0,64,-2,-1013,-1033,-1151,-1193,-1213,-1237,-1327,-1337,-1423,-1487,-1523,-1553,-1687,-1721,-1841,-1907,-2053,-2161,-2239,-2311,-2473,-2521,-2687,-2711,-2803,-2927,-3011,-3119,-3209,-3307,-3413,-3517,0.82,0.81,0.8,0.79,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,0.7,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62,0.61,0.6,0.59,0.58,0.57,0.56,0.55,0.54,0.53,0.52,0.51
	iCombDelTab_2L ftgen 0,0,64,-2,-953,-1049,-1093,-1129,-1163,-1249,-1277,-1367,-1381,-1451,-1483,-1567,-1637,-1759,-1871,-1973,-2063,-2153,-2251,-2357,-2467,-2557,-2663,-2749,-2857,-2963,-3061,-3181,-3257,-3343,-3467,-3547,0.82,0.81,0.8,0.79,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,0.7,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62,0.61,0.6,0.59,0.58,0.57,0.56,0.55,0.54,0.53,0.52,0.51
	iCombDelTab_2R ftgen 0,0,64,-2,-1061,-1181,-1259,-1321,-1373,-1453,-1459,-1571,-1579,-1657,-1663,-1777,-1783,-1873,-1877,-1987,-2081,-2179,-2269,-2377,-2477,-2591,-2677,-2767,-2879,-2971,-3079,-3191,-3271,-3359,-3491,-3559,0.82,0.81,0.8,0.79,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,0.7,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62,0.61,0.6,0.59,0.58,0.57,0.56,0.55,0.54,0.53,0.52,0.51
	
	iAllpassDelTab_1L ftgen 0,0,16,-2,-179,-223,-233,-311,-347,-409,-433,-509,0.76,0.74,0.72,0.7,0.68,0.64,0.62,0.6
	iAllpassDelTab_1R ftgen 0,0,16,-2,-199,-241,-313,-379,-419,-439,-521,-557,0.76,0.74,0.72,0.7,0.68,0.64,0.62,0.6
	iAllpassDelTab_2L ftgen 0,0,16,-2,-173,-257,-269,-353,-379,-457,-569,-509,0.76,0.74,0.72,0.7,0.68,0.64,0.62,0.6
	iAllpassDelTab_2R ftgen 0,0,16,-2,-191,-281,-337,-373,-431,-479,-587,-557,0.76,0.74,0.72,0.7,0.68,0.64,0.62,0.6
	
	kOn chnget "verb_on"    ; 0, 1
	
	if kOn > 0 then	
        kin	     chnget "verb_feed"  ; 0, 1      <~> slider @varname kittens @floatoutput 1 @min -1. @size 3. </~>
        krevtime chnget "verb_time"  ; .05, 3000 <~> umenu @item 1 , 2 , 4 </~>
        khiatt   chnget "verb_hiatt" ; 0, .99
        kpan     chnget "verb_pan"   ; 0, 360
        kdist    chnget "verb_dist"  ; .001, 15
        ktab     chnget "verb_tab"   ; 0, 1
       
	    kin = (kin^2) * 2
	    kdist = kdist + 1

	    aL, aR	 locsig ainL+ainR, kpan, kdist+0.5, .2
	    ar1, ar2 locsend 	
	             denorm ar1, ar2
	 
	    if ktab < 1 then 
	        a1   nreverb ar1*kin, krevtime, khiatt, 0, 32, iCombDelTab_1L, 8, iAllpassDelTab_1L
	        a2   nreverb ar2*kin, krevtime, khiatt, 0, 32, iCombDelTab_1R, 8, iAllpassDelTab_1R
	    else 
	        a1   nreverb ar1*kin, krevtime, khiatt, 0, 32, iCombDelTab_2L, 8, iAllpassDelTab_2L
	        a2   nreverb ar2*kin, krevtime, khiatt, 0, 32, iCombDelTab_2R, 8, iAllpassDelTab_2R
	    endif    
	    
	    a1	     tonex a1*.25, 10000, 2
	    a2	     tonex a2*.25, 10000, 2
	    aL	     dcblock aL + a1
	    aR       dcblock aR + a2
	else
	    aL = ainL
	    aR = ainR
	endif

	xout aL, aR
endop


instr 1
	aInL inch 1
    aInR inch 2

	aL, aR reeverb aInL, aInR

	outch 1, aL, 2, aR
endin


</CsInstruments>
<CsScore>
f0 7200
i1 0 7200
e
</CsScore>
</CsoundSynthesizer>







