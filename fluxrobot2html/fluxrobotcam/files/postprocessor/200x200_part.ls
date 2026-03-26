/PROG 200x200_part

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
  2: !Main Program                       -;
  3: !------------------------------------;
  4: LBL[100:"Initialize"] ;
  5: !Initialize all IO's                -;
  6: Call Initialize ;
  7: !Commands RA to Start Program       -;
  8: DO[53:ECAT_ProgramStart]=ON ;
  9: !Initialize Speeds for              -;
  10: ! Joint and Linear Motions          -;
  11: R[15:SPD_J]=50 ;
  12: R[16:SPD_L]=1000 ;
  13: !Initialize BendstateMachine        -;
  14: R[17:BendNumStatus]=1 ;
  15: !Initialize ProgramStateMachine     -;
  16: R[10:ProgramState]=1 ;
  17: R[19]=0 ;
  18: LBL[110:"ProgStateMach"] ;
  19: !Program Control State Machine      -;
  20: SELECT R[10:ProgramState]=1,JMP LBL[110] ;
  21: =2,JMP LBL[2] ;
  22: =3,JMP LBL[3] ;
  23: =4,JMP LBL[4] ;
  24: ELSE,JMP LBL[110] ;
  25: LBL[1:"PartPickupInit"] ;
  26: !------------------------------------;
  27: !Program starts when it gets        -;
  28: ! the DI for first bend from        -;
  29: ! machine and calls Pickup          -;
  30: !------------------------------------;
  31: If ((DI[51:ECAT_FirstBendActive] or (DI[51:ECAT_FirstBendActive] AND DI[52:ECAT_LastBendActive])) AND (R[19]<>1)) Then;
  32: !Write Userframe number in arg      -;
  33: Call Sub_PickUp(<Argument value>);
  34: ;
  35: !Write Userframe number in arg      -;
  36: Call Sub_CenteringTable(<Argument value>,<Argument value>);
  37: R[19]=1 ;
  38: ENDIF ;
  39: ;
  40: !Check if RAM is at TDC             -;
  41: IF (DO[51:ECAT_MoveToUDP] OR DI[51:ECAT_FirstBendActive] AND !DI[57:ECAT_UDP_Reached]) THEN ;
  42: R[10]=2 ;
  43: ENDIF ;
  44: ;
  45: !Check if the machine is ready      -;
  46: ! and move to next state            -;
  47: IF (DI[49:ECAT_NCStart] AND DI[59:ECAT_PressOk]) THEN ;
  48: !If machine is ready commands       -;
  49: ! the FASTCLOSING State             -;
  50: R[10]=3 ;
  51: JMP LBL[110] ;
  52: ELSE ;
  53: !Wait until condition satisfies     -;
  54: JMP LBL[110] ;
  55: ENDIF ;
  56: ;
  57: !Command RAM TO TDC                 -;
  58: LBL[2:RAMUP] ;
  59: DO[51:ECAT_MoveToUDP]=ON ;
  60: WAIT (DI[57:ECAT_UDP_Reached]) ;
  61: DO[51:ECAT_MoveToUDP]=OFF ;
  62: R[10]=1 ;
  63: JMP LBL[110] ;
  64: ;
  65: !------------------------------------;
  66: !Position Part For Bend             -;
  67: ! and Command FASTCLOSING           -;
  68: !------------------------------------;
  69: LBL[3:FASTCLOSING] ;
  70: !Check if both backgauges           -;
  71: ! are in it's Position              -;
  72: IF (DI[57:ECAT_UDP_Reached]) THEN ;
  73: DO[52:ECAT_StepChange]=ON ;
  74: WAIT (DI[50:ECAT_BackgaugeInPosition]) ;
  75: ELSE ;
  76: JMP LBL[110] ;
  77: ENDIF ;
  78: DO[55:ECAT_RoboUnsafe]=ON ;
  79: ;
  80: !------------------------------------;
  81: !State Machine to                   -;
  82: ! command Bend Sequence             -;
  83: !------------------------------------;
  84:  SELECT R[17]=1,CALL 0_BEND1Positioning_sub ;
  85:       =2,CALL 0_BEND2Positioning_sub ;
  86: ELSE,JMP LBL[4] ;
  87: ;
  88: !------------------------------------;
  89: !Check for bend sequence            -;
  90: ! completion and Command Deposit    -;
  91: !------------------------------------;
  92: IF (!DI[52:ECAT_LastBendActive]) THEN ;
  93: JMP LBL[3] ;
  94: ELSE ;
  95: IF (DI[52:ECAT_LastBendActive] AND R[10]>R[10]+1) THEN ;
  96: JMP LBL[4] ;
  97: ELSE ;
  98: JMP LBL[3] ;
  99: ENDIF ;
  100: ENDIF ;
  101: ;
  102: !------------------------------------;
  103: !Deposit Phase calls                -;
  104: !------------------------------------;
  105: LBL[4:TODEPOSIT] ;
  106: !Write Userframe number in arg      -;
  107: Call Sub_Deposit(<Argument value>);
  108: !Reset Registers                    -;
  109: R[10]=1    ;
  110: R[19]=0;
  111: !Loop Back to Initialize            -;
  112: JMP LBL[100] ;

/END
