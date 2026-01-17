3	REM   This program runs under BASIC80 and prints the first 100 Fibonacci numbers
5 DIGITS = 25            ' Should be enough for F(100)
10 DIM A(DIGITS), B(DIGITS), C(DIGITS)
15 TERMCOUNT = 100

20 FOR I = 1 TO DIGITS
30   A(I) = 0
40   B(I) = 0
50   C(I) = 0
60 NEXT I

70 B(DIGITS) = 1
80 PRINT " 0 --> 0"
90 PRINT " 1 --> 1"

100 FOR TERM = 2 TO TERMCOUNT
110   K = 0
120   FOR J = DIGITS TO 1 STEP -1
130     Z = A(J) + B(J) + K
140     IF Z > 9 THEN C(J) = Z - 10: K = 1 ELSE C(J) = Z: K = 0
150   NEXT J

160   LEAD = 0
161   S$ = ""
170   FOR J = 1 TO DIGITS
180     IF LEAD = 0 AND C(J) = 0 THEN 200
190     LEAD = 1: S$ = S$ + MID$("0123456789", C(J)+1, 1)
200   NEXT J
210   IF LEAD = 0 THEN S$ = "0"
220   PRINT TERM; "--> "; S$

230   FOR J = 1 TO DIGITS
240     A(J) = B(J)
250     B(J) = C(J)
260   NEXT J

270 NEXT TERM

280 PRINT : PRINT "Done."

290 END
