/PROG  M_TOOLINFO
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 570;
CREATE		= DATE 26-01-12  TIME 18:05:54;
MODIFIED	= DATE 26-03-25  TIME 14:40:40;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 16;
MEMORY_SIZE	= 910;
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

AUTO_SINGULARITY_HEADER;
  ENABLE_SINGULARITY_AVOIDANCE   : FALSE;

PLTZ_MODE_HEADER;
 PLTZ_MODE_ENABLE   : FALSE;
 J4TURN  : ZERORAD;
 ORIENT  : DOWNWARDS;
/MN
   1:  !------------------------------------; 
   2:  ! GET THE CURRENT TOOL VALUES AND   -;
   3:  ! CURR TCP POS FROM BGFRAME         -;
   4:  !------------------------------------; 
   5:  ! Get the value of current Tool     -;
   6:  R[37]=$MNUTOOLNUM[1] ;
   7:  ;
   8:  ! Store the curr Tool Data in PR[]  -;
   9:  PR[84:CurrentToolData]=UTOOL[R[37]] ;
  10:  ;
  11:  !------------------------------------; 
  12:  ! Send the Curr Tool values to PLC  -;
  13:  GO[10:FECaT_GI_CurTCPX]=(PR[84,1:CurrentToolData]*10) ;
  14:  GO[11:FECaT_GI_CurTCPY]=(PR[84,2:CurrentToolData]*10) ;
  15:  GO[12:FECaT_GI_CurTCPZ]=(PR[84,3:CurrentToolData]*10) ;
  16:  GO[13:FECaT_GI_CurTCPW]=(PR[84,4:CurrentToolData]*10) ;
  17:  GO[14:FECaT_GI_CurTCPP]=(PR[84,5:CurrentToolData]*10) ;
  18:  GO[15:FECaT_GI_CurTCPR]=(PR[84,6:CurrentToolData]*10) ;
  19:   ;
  20:  !------------------------------------; 
  21:  ! Send the Current TCP Pos from     -;
  22:  ! New BGFrame to the PLC            -; 
  23:  GO[7:FECaT_GI_PR71_X]=(PR[71,1:TCPPosInBGFrame]*10) ;
  24:  GO[8:FECaT_GI_PR71_Y]=(PR[71,2:TCPPosInBGFrame]*10) ;
  25:  GO[9:FECaT_GI_PR71_Z]=(PR[71,3:TCPPosInBGFrame]*10) ;
  26:  GO[23:FECat_GI_PR71_W]=(PR[71,4:TCPPosInBGFrame]*10) ;
  27:  GO[24:FECat_GI_PR71_P]=(PR[71,5:TCPPosInBGFrame]*10) ;
  28:  GO[6:FECaT_GI_PR71_R]=(PR[71,6:TCPPosInBGFrame]*10) ;
/POS
/END
