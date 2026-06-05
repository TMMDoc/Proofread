/PROG 0_Bend1Positioning_Sub

/ATTR
OWNER		= MNEDITOR;
COMMENT		= " ";
PROG_SIZE	= 3688;
CREATE		= DATE 24-12-04  TIME 11:41:24;
MODIFIED	= DATE 24-12-05  TIME 11:42:20;
FILE_NAME	= TESTDEF;
VERSION		= 0;
LINE_COUNT	= 133;
MEMORY_SIZE	= 4196;
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
  1: !------------------------------------;
  2: !Regrip Bend                        -;
  3: !Program for Positioning the        -;
  4: ! part at Machine.                  -;
  5: !Update current station as          -;
  6: ! Bending(Station 3)                -;
  7: ! for homing reference.             -;
  8: !------------------------------------;
  9: R[50]=3 ;
  10: ;
  11: !Label for program loop             -;
  12: LBL[11] ;
  13: !Check if Ram is not moving         -;
  14: IF (!DI[53:ECAT_RamMoving]) THEN ;
  15: !Start positioning the part         -;
  16: ! when no Ram motion                -;
  17: J P[7:PartInsert] R[15:SPD_J]% CNT10   ;
  18: L P[8:PartInsert2] R[16:SPD_L]mm/sec FINE   ;
  19: L P[9:MutePoint] R[16:SPD_L]mm/sec FINE   ;
  20: !Record Current position            -;
  21: ! for the BG_Align                  -;
  22: PR[78:LPOS_MUT]=LPOS ;
  23: ;
  24: ELSE ;
  25: !Wait until Ram Stops               -;
  26: WAIT (!DI[53:ECAT_RamMoving]) ;
  27: !Loop back to start                 -;
  28: JMP LBL[11] ;
  29: ENDIF ;
  30: ;
  31: !Command Ram motion Fastclosing     -;
  32: DO[55:ECAT_RoboUnsafe]=OFF ;
  33: DO[54:ECAT_EnableRamDown]=ON ;
  34: ;
  35: !Set current tool reference         -;
  36: R[38] = $MNUTOOLNUM[1];
  37: ;
  38: !------------------------------------;
  39: !Backgauge Alignment                -;
  40: !Calls with args describing         -;
  41: !(set val, exp val,No of Bg used)   -;
  42: !------------------------------------;
  43: CALL BG_ALIGN(6.5,3.855,2) ;
  44: WAIT (DI[58:ECAT_BelowMutePoint]) ;
  45: Utool_Num=3 ;
  46: JMP LBL[5] ;
  47: ;
  48: !------------------------------------;
  49: !Command clamping i.e,              -;
  50: !Command the Ram to move            -;
  51: ! to the pinch point                -;
  52: !------------------------------------;
  53: LBL[5:CLAMPING] ;
  54: DO[49:ECAT_ClampingPointBit]=ON ;
  55: WAIT (DI[54:ECAT_ClampingPointReach]) ;
  56: JMP LBL[6] ;
  57: ;
  58: !------------------------------------;
  59: !Call bend sync prog                -;
  60: ! and command Bending phase         -;
  61: !------------------------------------;
  62: LBL[6:MOVETOLDP] ;
  63: DO[54:ECAT_EnableRamDown]=OFF ;
  64:   R[17]=2 ;
  65: !------------------------------------;
  66: !Syncro Bend calls                  -;
  67: ! argument specifies the            -;
  68: ! number of sync points             -;
  69: !------------------------------------;
  70:  call 0_Bend1Sub (10)    ;
  71: !------------------------------------;
  72: !Initiate Regrip                    -;
  73: !------------------------------------;
  74: Call FUNCCombiGripper(10,2,0) ;
  75: WAIT 0.5(sec) ;
  76: L P[15:Swivel 1] R[16:SPD_L]mm/sec FINE   ;
  77: L P[16:Swivel 2] R[16:SPD_L]mm/sec FINE   ;
  78: L P[17:Contact] R[16:SPD_L]mm/sec FINE   ;
  79: Call FUNCCombiGripper(10,1,0) ;
  80: !Wait after Regrip                  -;
  81: wait 1(sec);
  82: ;
  83: !Reset IO's                         -;
  84: DO[52:ECAT_StepChange]=OFF ;
  85: DO[49:ECAT_ClampingPointBit]=OFF ;
  86: DO[51:ECAT_MoveToUDP]=ON ;
  87: WAIT (DI[57:ECAT_UDP_Reached]) ;
  88: DO[51:ECAT_MoveToUDP]=OFF ;
  89: L P[18:Decompress] R[16:SPD_L]mm/sec FINE   ;
  90: L P[19:Opening] R[16:SPD_L]mm/sec FINE   ;
  91: L P[20:PostBendSafe] R[16:SPD_L]mm/sec FINE   ;
  92: J P[21:Post Bend Safe2] R[15:SPD_J]% CNT10   ;
  93: ;
  94: !Reset IO's                         -;
  95: DO[50:ECAT_MoveToLDP]=OFF ;
  96: DO[49:ECAT_ClampingPointBit]=OFF ;
  97: DO[50:ECAT_MoveToLDP]=OFF ;
  98: !Set Bend complete state            -;
  99:   R[17]=2 ;
  100: ;
/POS
P[7:"PartInsert"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -395.00 mm, Z = 140.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[8:"PartInsert2"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -95.00 mm, Z = 140.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[9:"MutePoint"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -95.00 mm, Z = 100.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[10:"PinchPoint"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -85.00 mm, Z = 100.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[11:"RetractGauges"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -85.00 mm, Z = 100.00 mm,
W = 0.00 deg, P = 0.00 deg, R = 90.00 deg
};
P[12:"Bending"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -60.00 mm, Z = 157.00 mm,
W = 0.00 deg, P = 45.00 deg, R = 90.00 deg
};
P[13:"OverBending"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -59.00 mm, Z = 158.00 mm,
W = 0.00 deg, P = 45.97 deg, R = 90.00 deg
};
P[14:"Retract"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -663.00 mm, Y = -261.00 mm, Z = 158.00 mm,
W = 30.23 deg, P = 41.52 deg, R = 105.44 deg
};
P[15:"Swivel 1"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -701.00 mm, Y = -257.00 mm, Z = 164.00 mm,
W = -45.61 deg, P = -1.17 deg, R = 0.81 deg
};
P[16:"Swivel 2"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -77.00 mm, Z = 141.00 mm,
W = -45.97 deg, P = 0.00 deg, R = 0.00 deg
};
P[17:"Contact"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -59.00 mm, Z = 158.00 mm,
W = -45.97 deg, P = 0.00 deg, R = 0.00 deg
};
P[18:"Decompress"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -60.00 mm, Z = 157.00 mm,
W = -45.00 deg, P = 0.00 deg, R = 0.00 deg
};
P[19:"Opening"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -59.00 mm, Z = 183.00 mm,
W = -45.97 deg, P = 0.00 deg, R = 0.00 deg
};
P[20:"PostBendSafe"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -695.00 mm, Y = -359.00 mm, Z = 183.00 mm,
W = -45.97 deg, P = 0.00 deg, R = 0.00 deg
};
P[21:"Post Bend Safe2"]{
GP1:
UF : 1, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -1376.00 mm, Y = -425.00 mm, Z = 266.00 mm,
W = -179.72 deg, P = 0.40 deg, R = 135.00 deg
};

/END
