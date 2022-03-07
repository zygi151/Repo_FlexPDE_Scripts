!		1D_RC_DC_Transient_State
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.18/W64
!		Script Ver. 1.01
!
!		Description:
!			The script shows how change voltage on Resistor - Capaciator, after connection const DC Voltage.
! 		TO DO:
!			Match unit parametr
!			Change Twsp -> Time constant in RC circuit
!			Comment ?

TITLE "1D_RC_DC_Transient_State"

COORDINATES 	Cartesian1

VARIABLES
 	  Uin ( threshold = 0.01 )
 	, Uc 	 ( threshold = 0.01 )
 	, Ur 	 ( threshold = 0.01 )
 	, i 	 ( threshold = 0.01 )
    
 
DEFINITIONS
! RC - example parametr
			R= 2
			C = 5e-3
			Talu = R * C
        
! Other parametr   
				Twsp = 8
        		Tzoom = 2e-3
        		Scale = Tzoom
                
! Time parametr
Tstart = -10e-3 		T1 = 0	
                        		T2 =Twsp * ( Talu ) 	Tend = 5 / 3 * T2 
                            	                          		  	Tstep = 1e-3 ! Zmienic na 1e-3

EQUATIONS
	Uin :  Uin= ( upulse ( T - T1, T - T2 ) )			! Uin it was a const voltage
   
    	Uc : dt ( Uc ) = (  ( Uin  - Uc ) / ( Talu ) )	! Voltage on capaciator
    	Ur : Ur = R * i											! Voltage on Resistor - it was not unnecessary but I want to use equations var
    
    i : i =  C * dt( Uc ) 										! Current in circuit
   
BOUNDARIES  
    	REGION 1 start  ( Tstart )	
                                    LINE TO ( T1 ) 
        	    						LINE TO ( T2 ) 
        									LINE TO  (  Tend  )                                 
         
MONITORS
    TIME tstart TO  tend
   
PLOTS
    FOR T=Tstart BY Tstep TO Tend   
		HISTORY( Uin, Uc,  i  )	AT ( 1 )  as"#_1.Waveforms of voltages"
        	WINDOW( 0, Tend ) 
                
        HISTORY( Uin, Uc,  i ) 	AT ( 1 ) as"#_2.Before connected"
        	WINDOW ( Tstart, -1e-3 ) 		
        
        HISTORY( Uin , Uc, i ) 	AT ( 1 ) as "#_3.Charge phase."
        	WINDOW ( T1, T2- Scale ) 		
                
        HISTORY( Uc, i  )  		AT ( 1 ) as "#_4.Stady state"
        	WINDOW ( T2- Scale , T2 )  
            	! zmienić to

        HISTORY( Uc, i )  		AT ( 1 ) as "#_5.Discharge phase"
        	WINDOW ( T2- Scale-Scale , Tend )              
            
SUMMARY
	SUMMARY ("Comment__")
	Report("Data:")
    Report("  Uin - Input voltage")
    Report("   ")
    Report("  Ur - Voltage on resistor")
    Report("  Uc - Volgate on captacitor")
    Report("    ")
    Report("  Uout = Ur + Uc ")
    Report("  Uout = i * r + C * d(u)/dt ")
    Report("    ")
    Report("#_1. All characteristics. ")
    Report("#_2. Befor start ")
    Report(" Time < 0 ")
    Report(" Uin = Uout = Uc = Ur = i = 0 ")
    Report("    ") 
    Report("#_3. Charge phase ")
    Report("  Time = 0, TIme -> infinity ")
    Report("  Uin= const = 1, ic = C * d(u)/dt,  ")
    Report("   i -> 0 ")
	Report("#_4. The system goes into steady state. ")
    Report("   Time > 5 * Talu ")
    Report("   Uc = Uin, i = 0 ")
    Report("   ")
    Report("#_5. Discharge phase")
    Report("  Uin = 0, ")
    Report("  ")           
END