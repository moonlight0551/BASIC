1  REM THIS VERSION IS FROM A SCANNED VERSION FROM 101 BASIC COMPUTER GAMES
2  REM BY DEC AND CLEANED UP BY CHATGPT
7  REM LUNAR1 IS AN INTERACTIVE GAME THAT SIMULATES A LUNAR LANDING.
8  REM LANDING SIMILAR TO THAT OF THE APOLLO PROGRAM.
9  REM THERE IS ABSOLUTELY NO CHANCE INVOLVED.

11 REM'--- Initialize game variables ---
12 LET Z$="GO"                ' Main control for replay/flow
13 LET B1=1                   ' Instruction branch (1=first time, 3=skip)
20 LET M=17.95                ' Module mass (initial, units unspecified)
25 LET F1=5.25                ' Max thrust (unit-dependent)
30 LET N=7.5                  ' ??? (not clearly documented)
35 LET R0=926                 ' Initial orbital radius
40 LET V0=1.29                ' Initial vertical velocity (or possibly horizontal)
45 LET T=0                    ' Total mission elapsed time
50 LET H0=60                  ' Initial height above surface
55 LET R=R0+H0                ' Starting radius (from moon center)
60 LET A=-3.425               ' Initial attitude angle (degrees/radians)
65 LET R1=0                   ' Initial vertical velocity (possibly horizontal)
70 LET A1=8.84361E-04         ' Initial angular velocity
75 LET R3=0                   ' Temporary for physics calculations
80 LET A3=0                   ' Temporary for physics calculations
85 LET M1=7.45                ' Initial fuel mass
90 LET M0=M1                  ' Backup of initial fuel
95 LET B=750                  ' Engine constant (scaling)
100 LET T1=0                  ' User-input time interval for burn
105 LET F=0                   ' User-input thrust (%)
110 LET P=0                   ' User-input attitude angle (degrees)
115 LET N=1                   ' Loop/step count for integrations
120 LET M2=2                  ' Temporary for mass consumption
125 LET S=0                   ' Sine of attitude
130 LET C=0                   ' Cosine of attitude

131 REM'--- Show instructions if needed ---
135 IF Z$="YES" THEN 1150

138 REM '--- Begin main game prompt ---
140 PRINT
145 PRINT "LUNAR LANDING SIMULATION"
150 PRINT
155 PRINT "HAVE YOU FLOWN ON AN APOLLO/LEM MISSION BEFORE";
160 PRINT "(YES OR NO)";
165 INPUT Q$
170 IF Q$="YES" THEN 190           ' Experienced user
175 IF Q$="NO" THEN 210            ' New user
180 PRINT "JUST ANSWER THE QUESTION, PLEASE";
185 GOTO 165

187 REM '--- Experienced: go straight to unit choice ---
190 PRINT
195 PRINT "ENTER MEASUREMENT OPTION NUMBER";
200 GOTO 225

205 REM '--- New: show unit options, prompt for choice ---
210 PRINT
215 PRINT "WHICH SYSTEM OF MEASUREMENT DO YOU PREFER ?"
216 PRINT "1=METRIC    0=ENGLISH"
220 PRINT "ENTER THE APPROPRIATE NUMBER";
225 INPUT K
230 PRINT
235 IF K=0 THEN 280           ' Branch: English
240 IF K=1 THEN 250           ' Branch: Metric
245 GOTO 220

248 REM'--- Metric units ---
250 LET Z=1852.8              ' 1 nautical mile in meters
255 LET M$="METERS"           ' Unit label for printouts
260 LET G3=3.6                ' m/s to km/hr
265 LET N$="KILOMETERS"       ' Distance label
270 LET G5=1000               ' 1 km = 1000 m
275 GOTO 305

278 REM'--- English units ---
280 LET Z=6080                ' 1 nautical mile in feet
285 LET M$="FEET"             ' Unit label
290 LET G3=.592               ' ft/s to mph
295 LET N$=" N.MILES"         ' Distance label
300 LET G5=Z                  ' For distance conversion

302 REM '--- Begin main simulation or repeat ---
305 IF B1=3 THEN 670          ' Skip instructions if B1=3 (repeat run)
310 IF Q$="YES" THEN 485      ' Skip instructions for experienced user
312 REM '--- Instructions for new users ---
315 PRINT
320 PRINT "YOU ARE ON A LUNAR LANDING MISSION. AS THE PILOT OF"
325 PRINT "THE LUNAR EXCURSION MODULE, YOU WILL BE EXPECTED TO"
330 PRINT "GIVE CERTAIN COMMANDS TO THE MODULE NAVIGATION SYSTEM."
335 PRINT "THE ON BOARD COMPUTER WILL GIVE A RUNNING ACCOUNT"
340 PRINT "OF INFORMATION NEEDED TO NAVIGATE THE SHIP."
345 PRINT
350 PRINT
355 PRINT "THE ATTITUDE ANGLE CALLED FOR IS DESCRIBED AS FOLLOWS-"
360 PRINT "+ OR - 180 DEGREES IS DIRECTLY AWAY FROM THE MOON"
365 PRINT "-90 DEGREES IS ON A TANGENT IN THE DIRECTION OF ORBIT"
370 PRINT "90 DEGREES IS ON A TANGENT FROM THE DIRECTION OF ORBIT"
375 PRINT "0 (ZERO) DEGREES IS DIRECTLY TOWARD THE MOON"
380 PRINT
385 PRINT
385 PRINT TAB(30);"-180,180"
390 PRINT TAB(34);"^"
395 PRINT TAB(27);"-90 < -+- > 90"
400 PRINT TAB(34);"!"
405 PRINT TAB(34);"0"
410 PRINT TAB(23);"<< DIRECTION OF ORBIT <<"
415 PRINT
420 PRINT TAB(27);"SURFACE OF MOON"
425 PRINT
430 PRINT
435 PRINT "ALL ANGLES BETWEEN -180 AND 180 DEGREES ARE ACCEPTED."
440 PRINT
445 PRINT "1 FUEL UNIT = 1 SEC. AT MAX. THRUST"
450 PRINT "ANY DISCREPANCIES ARE ACCOUNTED FOR IN THE USE OF FUEL"
455 PRINT "FROM AN ATTITUDE CHANGE."
460 PRINT "AVAILABLE ENGINE POWER: 0 (ZERO) AND ANY VALUE BETWEEN"
465 PRINT "10 AND 100 PERCENT"
470 PRINT
475 PRINT "NEGATIVE THRUST OR TIME IS PROHIBITED"
480 PRINT
485 PRINT
490 PRINT "INPUT: TIME INTERVAL IN SECONDS ------ (T)"
495 PRINT "        PERCENTAGE OF THRUST --------- (P)"
500 PRINT "        ATTITUDE ANGLE IN DEGREES ---- (A)"
505 PRINT
510 IF Q$="YES" THEN 535
515 PRINT "FOR EXAMPLE:"
520 PRINT "T,P,A?10,65,-60"
525 PRINT "TO ABORT THE MISSION AT ANY TIME, ENTER 0,0,0"
530 PRINT
535 PRINT "OUTPUT: TOTAL TIME ELAPSED IN SECONDS"
540 PRINT "        HEIGHT IN ";M$
545 PRINT "        DISTANCE FROM LANDING SITE IN ";M$
550 PRINT "        VERTICAL VELOCITY IN ";M$;"/SECOND"
555 PRINT "        HORIZONTAL VELOCITY IN ";M$;"/SECOND"
560 PRINT "        FUEL UNITS REMAINING"
565 PRINT
570 GOTO 670

572 REM '--- Main game loop: User input for burn ---
575 PRINT
580 PRINT "T,P,A";
585 INPUT T1,F,P                ' Input: interval (sec), thrust %, attitude (deg)
590 LET F=F/100                 ' Convert thrust to fraction
595 IF T1<0 THEN 925            ' Negative time not allowed
600 IF T1=0 THEN 1092           ' 0 time is abort signal
605 IF ABS(F-.05)>1 THEN 945    ' Thrust out of range check
610 IF ABS(F-.05)<.05 THEN 945  ' Thrust too low check
615 IF ABS(P)>180 THEN 925      ' Attitude angle limit
620 LET N=20                    ' Number of integration steps

623 REM'--- Use finer steps for longer burns ---
625 IF T1<400 THEN 635
630 LET N=T1/20
635 LET T1=T1/N                 ' Break interval into small steps
640 LET P=P*3.14159/180         ' Convert attitude angle to radians
645 LET S=SIN(P)                ' Calculate sine for attitude
650 LET C=COS(P)                ' Calculate cosine for attitude
652 LET M2=M0*T1*F/B            ' Compute fuel to be used this step
660 LET R3=-.5*R0*((V0/R)^2)+R*A1*A1   ' Calculate vertical physics term (orbital/centripetal)
665 LET A3=-2*R1*A1/R                  ' Calculate angular acceleration

667 REM '--- Integrate physics over N steps ---
670 FOR I=1 TO N
675 IF M1=0 THEN 725            ' Out of fuel: skip thrust
680 LET M1=M1-M2
685 IF M1>0 THEN 725            ' If fuel still left, skip fuel exhaustion block
690 LET F=F*(1+M1/M2)           ' Thrust scaling as fuel runs out
695 LET M2=M1+M2                ' Correct mass for next iteration
700 PRINT "YOU ARE OUT OF FUEL"
705 LET M1=0                    ' Set fuel to zero
710 GOTO 725
715 LET F=0                     ' No thrust if out of fuel
720 LET M2=0                    ' No more fuel can be used

722 REM '--- Update physical state ---
725 LET M=M-.5*M2               ' Update spacecraft mass
730 LET R4=R3
735 LET R3=-.5*R0*((V0/R)^2)+R*A1*A1
740 LET R2=(3*R3-24)/2+.20526*F1*F*C/M
745 LET A4=A3
750 LET A3=-2*R1*A1/R
755 LET A2=(3*A3-A4)/2+.00526*F1*F*S/(M*R)
760 LET X=R1*T1+.5*P2*T1*T1     ' Position update; typo P2 should be R2?
765 LET R=R+X                   ' Update radius (position)
770 LET H0=H0+X                 ' Update altitude above surface
775 LET R1=R1+R2*T1             ' Update vertical velocity
780 LET A=A+A1*T1+.5*A2*T1*T1   ' Update attitude
785 LET A1=A1+A2*T1             ' Update angular velocity
790 LET M=M-.5*M2               ' Update spacecraft mass
795 LET T=T+T1                  ' Update mission elapsed time

798 REM '--- If landed, break loop ---
800 IF H0<3.287828E-04 THEN 810
805 NEXT I

807 REM '--- On touchdown or loop exit, compute outputs ---
810 LET H=H0*Z                  ' Altitude converted to print units
815 LET H1=R1*Z                 ' Vertical velocity in print units
820 LET D=R0*A*Z                ' Horizontal distance from landing site
825 LET D1=R*A1*Z               ' Horizontal velocity
830 LET T2=M1*B/M0              ' Remaining fuel, possibly scaled

835 PRINT TAB(1);T;TAB(10);H;TAB(23);D;
840 PRINT TAB(37);H1;TAB(49);D1;TAB(60);T2

843 REM '--- Check end-game conditions ---
845 IF H0<3.287828E-04 THEN 880         ' Landed
850 IF R0*A>164.4736 THEN 1050          ' Too far from landing site: lost in space
855 IF M1>0 THEN 580                    ' More fuel, repeat input loop
860 LET T1=22                           ' Arbitrary time step for forced landing?
865 LET F=0                             ' No thrust
870 LET P=0                             ' Attitude reset
875 GOTO 620                            ' Repeat integration

877 REM'--- Check safe landing or crash conditions ---
880 IF R1<-8.21957E-04 THEN 1020        ' Too high downward speed: crash
885 IF ABS(R*A1)>4.931742E-04 THEN 1020 ' Too high horizontal speed: crash
890 IF H0<-3.287828E-04 THEN 1020       ' Below surface: crash
895 IF ABS(D)>10*Z THEN 1065            ' Missed landing site by too much

897 REM '--- Successful landing! ---
900 PRINT
1000 PRINT "TRANQUILITY BASE HERE -- THE EAGLE HAS LANDED"
1005 PRINT "CONGRATULATIONS - THERE WAS NO SPACECRAFT DAMAGE"
1010 PRINT "YOU MAY NOW PROCEED WITH SURFACE EXPLORATION."
1015 GOTO 1100

1017 REM '--- Crash landing ---
1020 PRINT
1025 PRINT "CRASH !!!!!!!!!!"
1030 PRINT "YOUR IMPACT CREATED A CRATER ";ABS(H);M$;" DEEP"
1035 LET X1=SQR(D1*D1+H1*H1)*G3
1040 PRINT "AT CONTACT YOU WERE TRAVELLING ";X1;N$;"/HR."
1045 GOTO 1100

1047 REM '--- Lost in space ---
1050 PRINT
1055 PRINT "YOU HAVE BEEN LOST IN SPACE WITH NO HOPE OF RECOVERY"
1060 GOTO 1100

1062 REM '--- Safe but missed landing site ---
1065 PRINT "YOU ARE DOWN SAFELY - "
1075 PRINT
1080 PRINT "BUT MISSED THE LANDING SITE BY ";ABS(D/G5);N$
1085 GOTO 1100

1087 REM'--- Abort ---
1090 PRINT
1095 PRINT "MISSION ABORTED"

1097 REM'--- Play again prompt ---
1100 PRINT
1105 PRINT "DO YOU WANT TO FLY IT AGAIN ? (YES OR NO)";
1110 INPUT Z$
1115 IF Z$="YES" THEN 20
1120 IF Z$="NO" THEN 1130
1125 GOTO 1125

1130 PRINT
1135 PRINT "TOO BAD, THE SPACE PROGRAM HATES TO LOSE EXPERIENCED"
1140 PRINT " ASTRONAUTS."
1145 STOP

1147 REM '--- Full instructions (if selected at start) ---
1150 PRINT
1155 PRINT "OK, DO YOU WANT THE COMPLETE INSTRUCTIONS OR THE INPUT-"
1160 PRINT "OUTPUT STATEMENTS ?"
1165 PRINT "1=COMPLETE INSTRUCTIONS"
1170 PRINT "2=INPUT-OUTPUT STATEMENTS"
1175 PRINT "3=NEITHER"
1180 INPUT B1
1185 LET Q$="NO"
1190 IF B1=1 THEN 205
1195 LET Q$="YES"
1200 IF B1=2 THEN 190
1205 IF B1=3 THEN 190
1210 GOTO 1165
1215 END

