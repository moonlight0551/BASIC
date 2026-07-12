10 REM ****************************************
20 REM * CP/M FRACTAL COLLECTION             *
30 REM * PROGRAM : JULIA.BAS                 *
40 REM * VERSION : 1.4                       *
50 REM * STATUS  : RELEASED                  *
60 REM * DATE    : 12-JUL-2026               *
70 REM ****************************************
80 REM
90 REM VERSION HISTORY
100 REM V1.0 Initial Development Release
110 REM V1.1 Added Julia presets
120 REM V1.2 Added preset scaling variables
130 REM V1.3 Added camera offsets XC and YC
140 REM V1.4 Tuned preset viewpoints
150 REM ****************************************

160 PRINT
170 PRINT "***************************************"
180 PRINT "*     CP/M FRACTAL COLLECTION         *"
190 PRINT "***************************************"
200 PRINT
210 PRINT "PROGRAM 3 - JULIA SETS"
220 PRINT
230 PRINT "1 - SPIRAL"
240 PRINT "2 - DOUADY RABBIT"
250 PRINT "3 - DRAGON"
260 PRINT

270 INPUT "SELECT JULIA SET (1-3) ";SEL

280 IF SEL<1 THEN SEL=1
290 IF SEL>3 THEN SEL=3

300 INPUT "MAXIMUM ITERATIONS (8-16) ";ITMAX

310 IF ITMAX<8 THEN ITMAX=8
320 IF ITMAX>16 THEN ITMAX=16

330 REM --------------------------------------
340 REM SELECT JULIA PRESET
350 REM --------------------------------------

360 IF SEL=1 THEN GOTO 430
370 IF SEL=2 THEN GOTO 500

380 REM DRAGON

390 CA=.285
400 CB=.01
410 XS=.0458
420 YS=.08333
425 XC=-.015
426 YC=.005
427 GOTO 520

430 REM SPIRAL

440 CA=-.7269
450 CB=.1889
460 XS=.035
470 YS=.064
475 XC=-.020
476 YC=.005
477 GOTO 520

500 REM DOUADY RABBIT

510 CA=-.123
515 CB=.745
516 XS=.0458
517 YS=.08333
518 XC=-.030
519 YC=.005

520 PRINT

530 IF SEL=1 THEN PRINT "Generating Spiral Julia Set..."
540 IF SEL=2 THEN PRINT "Generating Douady Rabbit Julia Set..."
550 IF SEL=3 THEN PRINT "Generating Dragon Julia Set..."

560 PRINT "Please wait."
570 PRINT

580 REM --------------------------------------
590 REM MAIN Y LOOP
600 REM --------------------------------------

610 FOR Y=-12 TO 12

620 REM --------------------------------------
630 REM MAIN X LOOP
640 REM --------------------------------------

650 FOR X=-39 TO 39

660 REM SCREEN COORDINATES BECOME Z

670 A=X*XS+XC
680 B=Y*YS+YC

690 REM ITERATE Z=Z*Z+C

700 FOR I=0 TO ITMAX-1

710 T=A*A-B*B+CA
720 B=2*A*B+CB
730 A=T

740 IF (A*A+B*B)>4 THEN GOTO 800

750 NEXT I

760 REM POINT INSIDE JULIA SET

770 PRINT " ";
780 GOTO 830

790 REM POINT ESCAPED

800 J=I
810 IF J>9 THEN J=J+7
820 PRINT CHR$(48+J);

830 NEXT X

840 PRINT

850 NEXT Y

860 PRINT
870 PRINT "Completed."
880 PRINT

890 REM ****************************************
900 REM END OF PROGRAM
910 REM ****************************************

920 END