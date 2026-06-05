/PROG 0_Sub_Deposit

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
  2: !Update the current station         -;
  3: ! as Deposit(Station 4)             -;
  4: ! for homing reference              -;
  5: !------------------------------------;
  6: R[50]=4 ;
  7: !------------------------------------;
  8: !Set Userframe                      -;
  9: ! and Tool for the deposit          -;
  10: !------------------------------------;
  11: UFRAME_NUM=AR[1] ;
  12: J P[35:DepositApproach] R[15:SPD_J]% CNT10   ;
  13: L P[36:Deposit] R[16:SPD_L]mm/sec FINE   ;
  14: !------------------------------------;
  15: !Vaccum off / Jaw open              -;
  16: ! to drop-off the part.             -;
  17: ! Use req arg for gripper           -;
  18: !------------------------------------;
  19: CALL FUNCCOMBIGRIPPER (10,2,0);
  20: WAIT .50(sec) ;
  21: J P[37:Clear] R[15:SPD_J]% CNT10   ;
  22: J P[38:DepositTransitionSwing] R[15:SPD_J]% CNT10   ;
  23: R[15:SPD_J]=100 ;
  24: !------------------------------------;
  25: !Reset all IO's                     -;
  26: DO[49:ECAT_ClampingPointBit]=OFF ;
  27: DO[50:ECAT_MoveToLDP]=OFF ;
  28: DO[51:ECAT_MoveToUDP]=OFF ;
  29: DO[52:ECAT_StepChange]=OFF ;
  30: DO[54:ECAT_EnableRamDown]=OFF ;
  31: DO[53:ECAT_StartProgram]=OFF ;
  32: !------------------------------------;
  33: !Reset Program state                -;
  34: R[19]=0;
  35: J P[39:Home] R[15:SPD_J]% CNT10   ;
  36: ;
/POS
P[35:"DepositApproach"]{
GP1:
UF : 3, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 83.00 mm, Y = 571.00 mm, Z = 365.00 mm,
W = 179.95 deg, P = 0.11 deg, R = 90.01 deg
};
P[36:"Deposit"]{
GP1:
UF : 3, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 600.00 mm, Y = 400.00 mm, Z = 108.00 mm,
W = 180.00 deg, P = 0.00 deg, R = -90.00 deg
};
P[37:"Clear"]{
GP1:
UF : 3, UT : 3,      CONFIG : 'N D B, 0, 0, 0',
X = -1030.00 mm, Y = 53.00 mm, Z = 2558.00 mm,
W = 0.42 deg, P = -20.27 deg, R = -135.14 deg
};
P[38:"DepositTransitionSwing"]{
GP1:
UF : 3, UT : 3,      CONFIG : 'N D B, 0, 0, 0',
X = -632.00 mm, Y = 438.00 mm, Z = 2556.00 mm,
W = -0.42 deg, P = -19.72 deg, R = 45.14 deg
};
P[39:"Home"]{
GP1:
UF : 3, UT : 3,      CONFIG : 'F U T, 0, 0, 0',
X = -1393.00 mm, Y = -334.00 mm, Z = 1386.00 mm,
W = -55.22 deg, P = -89.52 deg, R = 100.22 deg
};

/END
