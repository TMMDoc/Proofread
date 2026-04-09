/PROG  M_SATWISTADJUST
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 676;
CREATE		= DATE 25-12-26  TIME 10:32:12;
MODIFIED	= DATE 26-02-12  TIME 17:43:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 34;
MEMORY_SIZE	= 1188;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 5,5,0;
/APPL

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
   1:  !------------------------------------;
   2:  ! Set the AR values as follows      -;
   3:  ! AR[1,2,3,4] values are:           -;
   4:  ! 1 = UFrameNum -> Machine,         -;
   5:  ! 2 = UToolNum  -> Current tool,    -;
   6:  ! 3 = UFrameNum -> New BGFrame,     -;
   7:  ! 4 = UToolNum  -> New Shifted TCP  -;
   8:  !------------------------------------; 
   9:  UFRAME_NUM=AR[1] ;
  10:  UTOOL_NUM=AR[2] ;
  11:  ;
  12:  !------------------------------------; 
  13:  ! Initialize the PR[71] as Zero     -;
  14:  PR[71:TCPPosInBGFrame]=PR[76:Zero]   ;
  15:  !------------------------------------; 
  16:  ! Stores the curr joint pos in PR   -;
  17:  PR[75:POSInBGFrame]=JPOS    ;
  18:  ;
  19:  !------------------------------------; 
  20:  ! Set New BG Frame as curr UFrame   -;
  21:  UFRAME_NUM=AR[3] ;
  22:  !------------------------------------; 
  23:  L PR[75:POSInBGFrame] 100mm/sec FINE ;
  24:  ;
  25:  ! Stores the curr cart pos in PR    -;
  26:  PR[71:TCPPosInBGFrame]=LPOS    ;
  27:  !------------------------------------; 
  28:  ! To get the Curr TCP data and      -;
  29:  ! Curr pos info from BG frame       -; 
  30:  CALL TOOLINFO          			   -;
  31:  ;
  32:  !------------------------------------; 
  33:  ! Initialize New Tool value as zero -;
  34:  PR[73:NEW_TOOL]=PR[76:Zero]    ;
  35:  !------------------------------------; 
  36:  ! To get the TCP shift from PLC     -;
  37:  CALL GETSHIFTTCP                    -;
  38:  !------------------------------------; 
  39:  LBL[2] ;
  40:  ! Writes the NewTool value in UTool -;
  41:  UTOOL[AR[4]]=PR[73:NEW_TOOL] ;
  42:  ;
  43:  ! Set the UFrame and UTool          -;
  44:  UTOOL_NUM=AR[4] ;
  45:  UFRAME_NUM=AR[1] ;
  46:  ;
  47:  PR[75:POSInBGFrame]=LPOS ;
  48:  !------------------------------------; 
  49:  ! Apply Tool_Offset from PLC        -;
  50:  ! using the calculated paramaters   -;
  51:  TOOL_OFFSET CONDITION PR[74:offsetparmcheck],UTOOL[AR[4]] ;
  52:  ;
  53:  ! Skip motion when both the value   -;
  54:  ! of Z1&Z2 is lesser than EXP_VAL   -;
  55:  SKIP CONDITION R[2:ANA_VAL_Z1]<=R[26:EXP_VAL] AND R[5:ANA_VAL_Z2]<=R[26:EXP_VAL] ;
  56:  L PR[75:POSInBGFrame] 1deg/sec FINE Tool_Offset Skip,LBL[1] ACC10 ;
  57:  !------------------------------------; 
  58:  LBL[1] ;
  59:  ! Restore original tool frame       -;
  60:  ! after the BG alignment            -;
  61:  UTOOL_NUM=R[38] ;
  62:  END ; 
/POS
/END