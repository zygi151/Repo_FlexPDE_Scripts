!		1D_RC_DC_Transient_State
!		
!		Mail : dawid151@gmail.com			
!		
!		FlexPDE 	Ver. Lite 7.20 / W64 3D
!		Script 		Ver. 1.06
!
!		Github: 
!			https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			The script shows transient state in Resistor - Capaciator in series circuit

TITLE "1D_RC_DC_Transient_State"

COORDINATES 	Cartesian1

VARIABLES
 	  Uin	( threshold = 0.01 )								!	Input voltage
 	, Uc		( threshold = 0.01 )								!	Capaciator voltage
 	, Ur		( threshold = 0.01 )								!	Resistor voltage
 	, i			( threshold = 0.01 )								!	Current 
    
 
DEFINITIONS
! Example parametr - Rezistor and Capaciator
		R= 2															!	[ Ohm }
		C= 5000e-6													!	[ F ]
		Tau= R * C													!	[ s ]
        Tconst =  ( 7 * Tau ) 															! 	Transient state should be achieve after 3 to 5 time const. Here is 7 * tau

! Time parametr
		Tstart = -10e-3 		T1 = 0													!	Start time		Timestamp 1
		                        		T2 =Tconst  				Tend = 2 * T2	!	Timestamp 2	End time
		                            	                          		  	Tstep = 1e-2	!	Step time
                                                                            
! Scale the time courses in window											!	Only for better show characteristic in windows
		Scale = 							3e-3 											! 	Factory to scale window
        T_before_window = 		-2e-3
        T_Charge_window = 		T2- Scale  		
        T_Stady1_window= 		T2 - Scale * 2
        T_Stady2_window= 		T2 - Scale
        T_discharge_window = 	T2 - Scale * 2          

EQUATIONS	! Equations form:
    Ur : 	Ur = R * i												! Resistor voltage - unnecessary, but I want to use variable. To reducate it, in history windows must be write ( R * I )
    i 	 : 	i =  C * dt ( Uc ) 									! Current in circuit       
    Uc : 	dt ( Uc ) = ( ( Uin - Uc ) / ( R * C ) )		! Capaciator voltage		
  	Uin : Uin = ( upulse( T - T1, T - T2 ) )			! DC Voltage from T1 to T2 time
   
BOUNDARIES  
    REGION 1 			START ( Tstart )	
                         	           		LINE TO ( T1 ) LINE TO ( T2 ) LINE TO  ( Tend )                                 
MONITORS
    TIME Tstart 		TO Tend
   
PLOTS
    FOR T = Tstart 	BY Tstep 	TO Tend   
    
    	HISTORY( Uin, Uc,  i ) 	AT ( 1 ) as"#_Before comutation"	WINDOW ( Tstart, 							T_before_window ) 
        HISTORY( Uin , Uc, i ) 	AT ( 1 ) as "#_Charge phase"			WINDOW ( T1, 								T_charge_window )
        HISTORY( Uc, i  )  			AT ( 1 ) as "#_Stady state"				WINDOW ( T_stady1_window, 		T_stady2_window )  
        HISTORY( Uc, i )  			AT ( 1 ) as "#_Discharge phase"	WINDOW ( T_discharge_window, 	Tend )    
        HISTORY( Uin, Uc,  i )		AT ( 1 ) as"#_All characteristic"		WINDOW ( T1, 								Tend )
        
	SUMMARY ("Derivation of circuit equations : ")
    	!--------------------------------------------------------------------
        Report(" Uin = Ur + Uc")
        Report(" Ur = R * I")
        Report(" I = C * d( Uc ) / dt")		Report(" ")
        !--------------------------------------------------------------------
        Report(" Uin = R * i + Uc")
        Report(" Uin - Uc = R * i")
        Report(" Uin - Uc = R * C d( Uc ) / dt")
        Report(" d( Uc ) / dt = ( Uin - Uc ) / ( R * C )")
        !--------------------------------------------------------------------
END