/PROG  M_FUNCCOMBIGRIPPER
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "16:40 12-10";
PROG_SIZE	= 947;
CREATE		= DATE 25-08-08  TIME 12:03:46;
MODIFIED	= DATE 25-12-26  TIME 15:51:52;
FILE_NAME	= TESTDEF;
VERSION		= 0;
LINE_COUNT	= 49;
MEMORY_SIZE	= 1383;
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
   2:  ! Gripper control using Ar[1,2,3]   -;
   3:  ! 1 = TYPE (10=Vac, 20=Combi)       -;
   4:  ! 2 = VAC (1=ON, 2=OFF)             -;
   5:  ! 2 = PINCH (11=Close, 12=Open)     -;
   6:  ! 3 = CMBVAC (0=NA, 1=Fwd, 2=Bwd)   -;
   7:  !------------------------------------;
   8:  ! Select the Gripper element        -;
   9:  IF (AR[3]<>0 AND !RI[1]) THEN ;
  10:  JMP LBL[30] ;
  11:  ENDIF;
  12:  ! JUMP TO GRIPPER TYPE              -;
  13:  LBL[100] ;
  14:  JMP LBL[AR[1]] ;
  15:  !------------------------------------;
  16:  ! VACUUM GRIPPER CONTROL            -;
  17:  !------------------------------------;
  18:  LBL[10] ;
  19:  ! VACUUM ON / OFF                   -;
  20:  JMP LBL[AR[2]] ;
  21:  LBL[1] ;
  22:  ! VACUUM ON                         -;
  23:  DO[9:Vacuum_GripON\OFF]=OFF ;
  24:  END ;
  25:  ! VACUUM OFF                        -;
  26:  LBL[2] ;
  27:  DO[9:Vacuum_GripON\OFF]=ON ;
  28:  IF (AR[3]=2) THEN ;
  29:  JMP LBL[30] ;
  30:  ENDIF ;
  31:  END ;
  32:  !------------------------------------;
  33:  ! PINCH/COMBI GRIPPER JAW CONTROL   -;
  34:  !------------------------------------;
  35:  LBL[20] ;
  36:  ! PINCH OPEN / CLOSE                -;
  37:  JMP LBL[AR[2]] ;
  38:  LBL[11] ;
  39:  ! PINCH CLOSE                       -;
  40:  RO[2]=OFF ;
  41:  RO[1]=ON ;
  42:  END ;
  43:  LBL[12] ;
  44:  ! PINCH OPEN                        -;
  45:  RO[1]=OFF ;
  46:  RO[2]=ON ;
  47:  END ;
  48:  !------------------------------------;
  49:  ! COMBI GRIPPER VACUUM FWD/BWD      -;
  50:  !------------------------------------;
  51:  LBL[30] ;
  52:  ! PUSH THE VAC FORWARD              -;
  53:  IF (AR[3]=1) THEN ;
  54:  RO[4]=OFF ;
  55:  RO[3]=ON ;
  56:  ENDIF ;
  57:  ! PULL THE VAC BACKWARD             -;
  58:  IF (AR[3]=2) THEN ;
  59:  RO[3]=OFF ;
  60:  RO[4]=ON ;
  61:  ENDIF ;
  62:  END ;
/POS 
/END 