/PROG  M_SAFRAMESET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 781;
CREATE		= DATE 25-12-26  TIME 10:22:42;
MODIFIED	= DATE 26-02-06  TIME 12:12:44;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 16;
MEMORY_SIZE	= 1089;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 3,3,0;
/APPL

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
   1:  !------------------------------------;
   2:  ! Sets the New BG frame based on    -;
   3:  ! the current BG Pos.               -;
   4:  ! AR[1,2,3] values are:             -;
   5:  ! 1 = UFrameNum - New BG Frame,     -;
   6:  ! 2 = R - BG's Z1/Z2-Position,      -;
   7:  ! 3 = Calibrated zero BG-UFrameNum  -;
   8:  !------------------------------------;
   9:  ! Set the Calibrated Zero BGFrame   -;
  10:  ! as a initial UFrame               -;
  11:  UFRAME[AR[1]]=PR[AR[3]] ;
  12:  ;
  13:  ! Set BG frame values in local PR   -;
  14:  PR[10001]=UFRAME[AR[1]] ;
  15:  ;
  16:  ! BG - X Position                   -;
  17:  R[10001]=GI[4:ShftdFrame_Mac_X]    ;
  18:  ! BG - Z Position                   -;
  19:  R[10002]=R[AR[2]]*(-1)    ;
  20:  ;
  21:  !------------------------------------;
  22:  ! Calculate the new curr BG frame   -; 
  23:  !------------------------------------;
  24:  ! APPLY Y SHIFT                     -; 
  25:  PR[10001,2]=PR[10001,2]+R[10001]    ;
  26:  ! APPLY X SHIFT                     -;
  27:  PR[10001,1]=PR[10001,1]-R[10002]    ;
  28:  ! Z value - Machine R_shift         -;
  29:  PR[10001,3]=PR[10001,3]+GI[5:ShftdFrame_Mac_R]    ;
  30:  !------------------------------------;
  3l:  ! UPDATE UFRAME WITH NEW POS VALUES -;
  32:  !------------------------------------;
  33:  UFRAME[AR[1]]=PR[10001] ;
  34:  END ; 
/POS
/END
