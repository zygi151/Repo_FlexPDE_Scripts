!		1D_RL_DC_Transient_State
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.18/W64 Lite
!		Script Ver. 1.02
!
!		Github : https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			The script shows how change voltage on Resistor - coil, after connection const DC Voltage.
!
! 		TO DO:
!			Comment ?

TITLE "1D_RL_DC_Transient_State"

COORDINATES 	Cartesian1

VARIABLES
      Uout 	( Threshold=0.01 ) 	! Unnecessary
    , Uin	( Threshold=0.01 )
    , Ul 		( Threshold=0.01 )
    , Ur		( Threshold=0.01 )
    , i			( Threshold=0.01 )
    
    
DEFINITIONS	

! RL - Example parameters
						R = 4 			! [ ohm ]			 
						L = 50e-3 	! [ mH ]

! Other Parametr                        
						Twsp = 8 		! Time scale factor...
                      	Scale = 2e-3  	! Zoom on the.... something ( look at down )
                        
! Time parametr
Tstart = -10e-3 		T1 = 0	
                        		T2 = Twsp*( l / r ) 	Tend = 5 / 3 * T2 
                            	                            	Tstep = 1e-2
                                                            
EQUATIONS
	Uin : Uin = ( upulse ( T - T1, T - T2 ) )
    
    Uout : Uin - Ul - ( Ur ) = 0
    	Ul : Ul = Uout - ( Ur )		
	    Ur : Ur = i * R
    
	i : dt ( i ) = ( ( Uin - i * r ) / L ) 
    
BOUNDARIES  
    	REGION 1 Start  ( Tstart )	
                                    LINE TO ( T1 ) 
        	    						LINE TO ( T2 ) 
        									LINE TO  (  Tend  )

MONITORS
    TIME Tstart TO Tend

PLOTS
    FOR T=Tstart BY Tstep TO Tend   
		HISTORY( Uin, Ul,  i  )	AT ( 1 )  as"#_1.Waveforms of voltages"
        	WINDOW( 0, Tend ) 
                
        HISTORY( Uin, Ul,  i ) 	AT ( 1 ) as"#_2.Before connected"
        	WINDOW ( Tstart, -1e-3 ) 		
        
        HISTORY( Uin , Ul, i ) 	AT ( 1 ) as "#_3.Charge phase."
        	WINDOW ( T1, T2- Scale ) 		
                
        HISTORY( Ul, i  )  		AT ( 1 ) as "#_4.Stady state"
        	WINDOW ( T2- Scale-Scale-Scale , T2-Scale )  
            	! zmienić to

        HISTORY( Ul, i )  		AT ( 1 ) as "#_5.Discharge phase"
        	WINDOW ( T2- Scale-Scale , Tend ) 

SUMMARY ("Comment__")
	Report("Data:")
    Report("  Uin - Input voltage")
    Report("  Uout - Output voltage")
    Report("   ")
    Report("  Ur - Voltage on resistor")
    Report("  Ul - Volgate on coil")
    Report("    ")
    Report("  Uout = Ur + Ul ")
    Report("  Uout = i * r + L * d(i)/dt ")
    Report("    ")
    Report("#_1. All characteristics. ")
    Report("#_2. Befor start ")
    Report(" Time < 0 ")
    Report(" Uin = Uout = Ul = Ur = i = 0 ")
    Report("    ") 
    Report("#_3. Charge phase ")
    Report("  Time = 0, and TIme -> infinity ")
    Report("  Uin= const = 1, i-> Uin/R ")
    Report("    ")
	Report("#_4. The system goes into steady state. ")
    Report("   Time > 5 * ( L / R ) ")
    Report("   Ur = Uin, i = E/R ")
    Report("   ")
    Report("#_5. Discharge phase")
    Report("  Uin = 0, ")
    Report("  i -> 0 ")    
END