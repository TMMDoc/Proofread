/PROG 0_Sub_Pickup

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
  2: !Update current station as          -;
  3: ! Pickup(Station 1) for             -;
  4: ! homing reference                  -;
  5: !------------------------------------;
  6: R[50]=1 ;
  7: !Set Userframe and                  -;
  8: ! Tool for the pickup               -;
  9: UFRAME_NUM=AR[1];
  10: UTOOL_NUM=3;
  11: ;
  12: J P[2:Approach] R[15:SPD_J]% CNT10   ;
  13: R[16:SPD_L]=50;
  14: ;
  15: !------------------------------------;
  16: !Update the contact point           -;
  17: ! for stack search program          -;
  18: !------------------------------------;
  19:   PR[63]=P[3:Contact];
  20: ;
  21: !------------------------------------;
  22: !,Update with req arguments         -;
  23: ! for different gripper usage       -;
  24: !------------------------------------;
  25:   Call FUNCCombiGripper(10,1,1) ;
  26: ;
  27: !------------------------------------;
  28: !To pickup from top of the stack    -;
  29: !------------------------------------;
  30: Call Sub_StackSearch;
  31: ;
  32: R[16:SPD_L]=1000;
  33: wait 0.25(sec);
  34: L P[4:Separate] R[16:SPD_L]mm/sec FINE   ;
  35: L P[5:LiftClear] R[16:SPD_L]mm/sec FINE   ;
  36: J P[6:PickupTransitionSwing] R[15:SPD_J]% CNT10   ;
  37: ;
/POS
P[2:"Approach"]{
GP1:
UF : 2, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 81.00 mm, Y = 76.00 mm, Z = 105.00 mm,
W = 180.00 deg, P = 0.00 deg, R = 0.00 deg
};
P[3:"Contact"]{
GP1:
UF : 2, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 81.00 mm, Y = 76.00 mm, Z = 5.00 mm,
W = 180.00 deg, P = 0.00 deg, R = 0.00 deg
};
P[4:"Separate"]{
GP1:
UF : 2, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 81.00 mm, Y = 76.00 mm, Z = 55.00 mm,
W = 180.00 deg, P = 0.00 deg, R = 0.00 deg
};
P[5:"LiftClear"]{
GP1:
UF : 2, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = 228.00 mm, Y = 212.00 mm, Z = 779.00 mm,
W = 180.00 deg, P = 0.00 deg, R = 0.00 deg
};
P[6:"PickupTransitionSwing"]{
GP1:
UF : 2, UT : 3,      CONFIG : 'N U T, 0, 0, 0',
X = -1040.00 mm, Y = -1340.00 mm, Z = -78.00 mm,
W = -92.72 deg, P = -70.66 deg, R = 130.81 deg
};

/END
