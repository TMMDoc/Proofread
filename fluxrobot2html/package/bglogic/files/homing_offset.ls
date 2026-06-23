/PROG  HOMING_OFFSET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 416;
CREATE		= DATE 26-05-18  TIME 10:40:18;
MODIFIED	= DATE 26-05-18  TIME 10:40:18;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 10;
MEMORY_SIZE	= 748;
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
/MN
   1:  !-------------------------------- ;
   2:  ! Build PR[102] from registers ;
   3:  ! R[130]= X, R[131]= Y, R[132]= Z ;
   4:  !-------------------------------- ;
   5:  DO[63:ECAT_AutoHoming]=(F[70:HOMING]) ;
   6:   ;
   7:  PR[102,1]=R[130]    ;
   8:  PR[102,2]=R[131]    ;
   9:  PR[102,3]=R[132]    ;
  10:  ! W/P/R are left unchanged ;
/POS
/END
