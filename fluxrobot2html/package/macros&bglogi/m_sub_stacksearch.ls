/PROG  M_SUB_STACKSEARCH
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 313;
CREATE		= DATE 25-08-18  TIME 17:47:56;
MODIFIED	= DATE 26-02-12  TIME 10:30:30;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 10;
MEMORY_SIZE	= 777;
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
   2:  ! Search for the stack in           -;
   3:  ! Pickup pallet                     -;
   4:  !------------------------------------;
   5:  LBL[50:StackSearch] ;
   6:  R[16:SPD_L]=150 ;
   7:  !------------------------------------;
   8:  ! Skip the contact point motion     -;
   9:  !  when Proximity is ON             -;
  10:  !------------------------------------;
  11:  SKIP CONDITION DI[8:Stack_Height_FB]=ON ;
  12:  L PR[63:Contact] R[16:SPD_L]mm/sec FINE Skip,LBL[50] ;
  13:  !------------------------------------;
  14:  ! Turn ON suction of Vac gripper    -;
  15:  !------------------------------------;
  16:  DO[9:Vacuum_GripON\OFF]=ON ;
  17:  WAIT 0.50(sec) ;
  18:  R[16:SPD_L]=1000 ;
/POS
/END  