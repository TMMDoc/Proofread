/PROG  BGRESET_HOMINGHMI
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1742;
CREATE		= DATE 26-05-06  TIME 15:07:32;
MODIFIED	= DATE 26-05-06  TIME 15:11:18;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 68;
MEMORY_SIZE	= 2230;
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
   1:  ! Reset the Framecorrection value ;
   2:  ! from HMI page ;
   3:  !-------------------------------- ;
   4:  ! Select the Frame to Reset ;
   5:  ! based on the HMI flag signal ;
   6:  IF (F[66:MACHINE_RST]=ON),JMP LBL[10] ;
   7:  IF (F[67:PICKUP1_RST]=ON),JMP LBL[20] ;
   8:  IF (F[68:PICKUP2_RST]=ON),JMP LBL[30] ;
   9:  IF (F[69:CENTERING_RST]=ON),JMP LBL[40] ;
  10:  JMP LBL[99] ;
  11:  !-------------------------------- ;
  12:  !Reset Pressbrake Framecorrection ;
  13:  !-------------------------------- ;
  14:  LBL[10] ;
  15:  R[41:FrameCorr_PB_X]=0    ;
  16:  R[42:FrameCorr_PB_Y]=0    ;
  17:  R[43:FrameCorr_PB_Z]=0    ;
  18:  R[44:FrameCorr_PB_W]=0    ;
  19:  R[45:FrameCorr_PB_P]=0    ;
  20:  R[46:FrameCorr_PB_R]=0    ;
  21:  JMP LBL[99] ;
  22:  !-------------------------------- ;
  23:  ! RESET PICKUP1 FRAME CORRECTIONS ;
  24:  !-------------------------------- ;
  25:  LBL[20] ;
  26:  R[51:FrameCorr_PKU_X]=0    ;
  27:  R[52:FrameCorr_PKU_Y]=0    ;
  28:  R[53:FrameCorr_PKU_Z]=0    ;
  29:  R[54:FrameCorr_PKU_W]=0    ;
  30:  R[55:FrameCorr_PKU_P]=0    ;
  31:  R[56:FrameCorr_PKU_R]=0    ;
  32:  JMP LBL[99] ;
  33:  !-------------------------------- ;
  34:  ! RESET PICKUP2 FRAME CORRECTIONS ;
  35:  !-------------------------------- ;
  36:  LBL[30] ;
  37:  R[61:FrameCorr_PKU2_X]=0    ;
  38:  R[62:FrameCorr_PKU2_Y]=0    ;
  39:  R[63:FrameCorr_PKU2_Z]=0    ;
  40:  R[64:FrameCorr_PKU2_W]=0    ;
  41:  R[65:FrameCorr_PKU2_P]=0    ;
  42:  R[66:FrameCorr_PKU2_R]=0    ;
  43:  JMP LBL[99] ;
  44:  !-------------------------------- ;
  45:  !RESET CENTERING FRAMECORRECTIONS ;
  46:  !-------------------------------- ;
  47:  LBL[40] ;
  48:  R[71:FrameCorr_CNTR_X]=0    ;
  49:  R[72:FrameCorr_CNTR_Y]=0    ;
  50:  R[73:FrameCorr_CNTR_Z]=0    ;
  51:  R[74:FrameCorr_CNTR_W]=0    ;
  52:  R[75:FrameCorr_CNTR_P]=0    ;
  53:  R[76:FrameCorr_CNTR_R]=0    ;
  54:  JMP LBL[99] ;
  55:  !-------------------------------- ;
  56:  ! Build PR[102] from registers ;
  57:  ! R[130]=X, R[131]=Y, R[132]=Z ;
  58:  !-------------------------------- ;
  59:  LBL[50] ;
  60:  DO[63:ECAT_AutoHoming]=(F[64]) ;
  61:   ;
  62:   ;
  63:  PR[102,1]=R[130]    ;
  64:  PR[102,2]=R[131]    ;
  65:  PR[102,3]=R[132]    ;
  66:  ! W/P/R are left unchanged ;
  67:  JMP LBL[99] ;
  68:  LBL[99] ;
/POS
/END
