/PROG  M_FRAMECORRECTION
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 456;
CREATE		= DATE 25-10-16  TIME 14:31:14;
MODIFIED	= DATE 26-02-11  TIME 17:20:00;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 14;
MEMORY_SIZE	= 772;
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
   2:  ! Apply Frame correction values     -;
   3:  !------------------------------------;
   4:  ! Initial State: All Cartesian      -; 
   5:  ! values will be set to zero        -;
   6:  ! for Position register             -;
   7:  !------------------------------------;
   8:  PR[85]=PR[86:CartZero] ;
   9:  !------------------------------------;
  10:  ! Select the base register offset   -;
  11:  ! for the frame correction          -;
  12:  !------------------------------------;
  13:  ! AR[]= For Frame selection         -;
  14:  ! [1]= PressBrake, [2]= Pickup1,    -;
  15:  ! [3]= Pickup2, [4]= Centering      -;
  16:  !------------------------------------;
  17:  IF (AR[1]=1),R[10002]=(40) ;
  18:  IF (AR[1]=2),R[10002]=(50) ;
  19:  IF (AR[1]=3),R[10002]=(60) ;
  20:  IF (AR[1]=4),R[10002]=(70) ;
  21:  !------------------------------------;
  22:  ! Apply correction values to the    -;
  23:  !  Position register                -;
  24:  !------------------------------------;
  25:  ! Loop through X, Y, Z, W, P, R     -;
  26:  !------------------------------------;
  27:  FOR R[10001]=1 TO 6 ;
  28:  R[10003]=R[10001]+R[10002] ;
  29:  PR[85,R[10001]]=PR[85,R[10001]]+R[R[10003]] ;
  30:  ENDFOR ;
  31:  END ;
/POS 
/END 