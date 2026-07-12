10 REM ****************************************
20 REM * CP/M FRACTAL COLLECTION             *
30 REM * PROGRAM : MANDEL.BAS                *
40 REM * VERSION : 1.2                       *
50 REM * STATUS  : RELEASED                  *
60 REM * DATE    : 30-JUN-2026               *
70 REM ****************************************
80 REM
90 REM VERSION HISTORY
100 REM V1.0 Original published listing
110 REM V1.1 Comments and title screen
120 REM V1.2 User selectable iterations
130 REM ****************************************

140 PRINT
150 PRINT "***************************************"
160 PRINT "*     CP/M FRACTAL COLLECTION         *"
170 PRINT "***************************************"
180 PRINT
190 PRINT "PROGRAM 1 - MANDELBROT SET"
200 PRINT

210 INPUT "MAXIMUM ITERATIONS (8-16) ";ITMAX

220 IF ITMAX<8 THEN ITMAX=8
230 IF ITMAX>16 THEN ITMAX=16

240 PRINT
250 PRINT "Generating Mandelbrot Set..."
260 PRINT "Please wait."
270 PRINT

280 REM --------------------------------------
290 REM MAIN Y LOOP
300 REM --------------------------------------

310 FOR Y=-12 TO 12

320 REM --------------------------------------
330 REM MAIN X LOOP
340 REM --------------------------------------

350 FOR X=-39 TO 39

360 REM CONVERT SCREEN COORDINATES TO
370 REM COMPLEX PLANE COORDINATES

380 CA=X*0.0458
390 CB=Y*0.08333

400 REM INITIAL Z=C

410 A=CA
420 B=CB

430 REM ITERATE Z=Z*Z+C

440 FOR I=0 TO ITMAX-1

450 T=A*A-B*B+CA
460 B=2*A*B+CB
470 A=T

480 IF (A*A+B*B)>4 THEN GOTO 540

490 NEXT I

500 REM POINT IS INSIDE THE SET

510 PRINT " ";
520 GOTO 570

530 REM POINT ESCAPED

540 J=I
550 IF J>9 THEN J=J+7
560 PRINT CHR$(48+J);

570 NEXT X

580 PRINT

590 NEXT Y

600 PRINT
610 PRINT "Completed."
620 PRINT
630 END