/PROG  M_GETSHIFT_TCP
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 307;
CREATE		= DATE 26-01-28  TIME 14:50:06;
MODIFIED	= DATE 26-03-25  TIME 12:06:50;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 6;
MEMORY_SIZE	= 655;
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
   1:  !------------------------------------; 
   2:  ! NEW_TOOL values are received from -;
   3:  ! PLC and stored in R[81 to 86].    -;
   4:  ! The values from the R[] are       -;
   5:  ! then written in PR[73]            -;
   6:  !------------------------------------; 
   7:  PR[73,1:NEW_TOOL]=R[81]/10 ;
   8:  PR[73,2:NEW_TOOL]=R[82]/10 ;
   9:  PR[73,3:NEW_TOOL]=R[83]/10 ;
   10: PR[73,4:NEW_TOOL]=R[84]/10 ;
   11: PR[73,5:NEW_TOOL]=R[85]/10 ;
   12: PR[73,6:NEW_TOOL]=R[86]/10 ;
/POS
/END
