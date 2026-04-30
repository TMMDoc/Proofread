/PROG M_Initialize

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
DEFAULT_GROUP	= *,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/APPL

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN

  1: !-------------------------------;
  2: ! Reset all machine outputs    -;
  3: ! before initializing bending  -;
  4: !-------------------------------;
  5: DO[49:ECAT_ClampingPointBit]=OFF ; 
  6: DO[50:ECAT_MoveToLDP]=OFF ; 
  7: DO[51:ECAT_MoveToUDP]=OFF ; 
  8: DO[52:ECAT_StepChange]=OFF ; 
  9: DO[54:ECAT_EnableRamDown]=OFF ; 
  10: DO[53:ECAT_StartProgram]=OFF ; 
  11: !-------------------------------;
  12: ! Reset the program states     -;
  13: R[10]=1    ; 
  14: R[19]=0; 
  15: !------------------------------;
  16: ! Reset to First Bend         -;
  17: R[17]=1; 
  18: !------------------------------;

/POS
/END

