/PROG 0_BEND1SUB

/ATTR
OWNER		= MNEDITOR;
COMMENT		= "16:40 12-10";
PROG_SIZE	= 2991;
CREATE		= DATE 24-11-05  TIME 14:23:52;
MODIFIED	= DATE 24-12-10 TIME 16:40:08;
FILE_NAME	= TESTDEF;
VERSION		= 0;
LINE_COUNT	= 26;
MEMORY_SIZE	= 3391;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/APPL

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
  1:!-------------------------------------;
  2:!SYNCRO_BEND,                        -;
  3:! Arg[1] value is number             -;
  4:! of sync points                     -;
  5:!-------------------------------------;
  6: R[77]=AR[1];  
  7:!-------------------------------------;
  8:!Move the generated                  -;
  9:! positions to PR regs               -;
 10:! for dynamic command                -;
 11:!-------------------------------------;
 12: FOR R[33]=1 TO R[77]; 
 13: PR[R[33]]=P[R[33]] ; 
 14: ENDFOR ;
 15:!-------------------------------------;
 16: R[16:SPD_L]=2000;						
 17:!Release the part and                -;
 18:! regrip to comp for bg_align        -;  
 19:!-------------------------------------;
 20: Call FUNCCombiGripper(10,2,0) ; 
 21: WAIT   0.50(sec) ;
 22:!Move to first sync point            -;
 23: L P[1] R[16]mm/sec Fine ;
 24: WAIT    .5(sec) ;
 25: Call FUNCCombiGripper(10,1,0) ; 
 26: WAIT   1.00(sec) ;
 27:!Initialize register                 -;
 28: R[35]=0 ; 
 29:!-------------------------------------;
 30:!Initiate skip                       -;
 31:! condition for sync                 -; 
 32:!-------------------------------------;
 33: SKIP CONDITION R[35]<>R[34] ;
 34: R[36]=$Fast_Clock ;					  
 35: R[35]=R[34] ;				   
 36: LBL[2] ;
 37:!-------------------------------------;
 38:!Command Ram to move to LDP          -;
 39: DO[50:ECAT_MoveToLDP]=ON ;
 40:!Break out of loop                   -;
 41:! when decompress reached            -;
 42:!-------------------------------------;
 43: IF (DI[56]),JMP LBL[3]; 
 44:!Dynamic motion cmd for sync         -;
 45: L PR[R[35]] 1msec CNT100 ACC80 Skip,LBL[2] ;
 46: R[30]=$Fast_Clock ;					  
 47: JMP LBL[2] ; 
 48:!-------------------------------------;
 49:!Move to last command                -; 
 50:! position to ensure syncbend        -;
 51:!-------------------------------------;
 52: LBL[3] ;
 53: R[38]=$Fast_Clock ;					  
 54: R[32]=R[38]-R[36] ;						 
 55: R[31]=R[30]-R[36] ;						 
 56: L PR[R[35]] 1msec CNT100 ACC80; 
 57: R[15:SPD_J]=50 ;
 58: Pause;
 59:;
/POS
P[1:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -85.00 mm, Z = 100.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[2:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -84.00 mm, Z = 107.00 mm,
W = 0.00 deg, P = 5.00 deg, R = 90.00 deg
};
P[3:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -83.00 mm, Z = 114.00 mm,
W = 0.00 deg, P = 10.00 deg, R = 90.00 deg
};
P[4:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -82.00 mm, Z = 121.00 mm,
W = 0.00 deg, P = 15.00 deg, R = 90.00 deg
};
P[5:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -80.00 mm, Z = 128.00 mm,
W = 0.00 deg, P = 20.00 deg, R = 90.00 deg
};
P[6:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -77.00 mm, Z = 134.00 mm,
W = 0.00 deg, P = 25.00 deg, R = 90.00 deg
};
P[7:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -74.00 mm, Z = 141.00 mm,
W = 0.00 deg, P = 30.00 deg, R = 90.00 deg
};
P[8:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -70.00 mm, Z = 146.00 mm,
W = 0.00 deg, P = 35.00 deg, R = 90.00 deg
};
P[9:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -65.00 mm, Z = 152.00 mm,
W = 0.00 deg, P = 40.00 deg, R = 90.00 deg
};
P[10:""]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -60.00 mm, Z = 157.00 mm,
W = 0.00 deg, P = 45.00 deg, R = 90.00 deg
};

/END
