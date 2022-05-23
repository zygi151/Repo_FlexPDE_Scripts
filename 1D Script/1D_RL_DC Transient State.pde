!		1D_RL_DC_Transient_State
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
!			Script shows a characteristic in Resistor Coil serial circuit.

TITLE "1D_RL_DC_Transient_State"

COORDINATES 	Cartesian1

VARIABLES
    , Uin	( Threshold=0.01 )	! DC input voltage
    , UL		( Threshold=0.01 )	! Coil voltage
    , Ur		( Threshold=0.01 )	! Resistor voltage
    , i			( Threshold=0.01 )	! Current 
    
    
DEFINITIONS	
! Example parameters for Resistor and Coil
	R 		= 4 													!	[ ohm ]			 
    L 			= 50e-3 											!	[ mH ]
	talu 		= L / R																			! Time const in RL circuit
    Tconst = ( talu * 7 )																	! Stady stade should be in 3 to 5 time const. Here is 7.
    
! Time parametr
	Tstart = -10e-3 		T1 = 0														! Start time			Timestamp1
               	         			T2 = Tconst 			Tend 	= 2 * T2 		! Timestamp2		End time
                            	                            		Tstep 	= 1e-2			! Step time
                                                                
! Scale the time courses in window											! Only for better show characteristic in window
	Scale = 2e-3  																			
	T_before_window 		= -1e-3
	T_charge_window 		= T2 - Scale
	T_discharge_window	= T2 - Scale*2
	T_stady1_window 		= T2 - Scale*3	
    T_stady2_window 		= T2 - Scale                                           

EQUATIONS
    Uin : Uin = ( upulse ( T - T1, T - T2 ) )										! DC Voltage from T1 to T2 time
    Ur : 	Ur = R * i 																		! Resistor voltage
    UL: 	UL = L * dt( i )																	! Coil voltage
    i: 		dt( i ) = ( ( Uin - Ur ) / L )													! Current
    
BOUNDARIES  
    	REGION 1 
            Start  ( Tstart )	
                                    LINE TO ( T1 ) 	LINE TO ( T2 ) 	LINE TO  ( Tend )

MONITORS
    TIME Tstart 		TO Tend

PLOTS
    FOR T = Tstart 	BY Tstep TO Tend   
    
        HISTORY( Uin, Ul,  i ) 	AT ( 1 ) as "#_Before comutation"        	WINDOW ( Tstart, 							T_Before_window ) 		
        HISTORY( Uin , Ul, i ) 	AT ( 1 ) as "#_Charge phase"	        		WINDOW ( T1, 								T_charge_window ) 		
        HISTORY( Ul, i  )  		AT ( 1 ) as "#_Stady state"						WINDOW ( T_stady1_window,		T_stady2_window )  		
        HISTORY( Ul, i )  		AT ( 1 ) as "#_Discharge phase"	       	WINDOW ( T_discharge_window, 	Tend ) 	
        HISTORY( Uin, Ul,  i  )	AT ( 1 ) as "#_All characteristic"	        	WINDOW ( T1, 								Tend ) 

SUMMARY ("Derivation of circuit equations : ")
	Report("Uin = Ur + UL")
    Report("Uin = Ur + L * di( i ) /dt")
    Report("Uin - Ur = L  * di( i ) /dt")
    Report("di( i ) /dt = ( Uin - Ur ) / L")
END