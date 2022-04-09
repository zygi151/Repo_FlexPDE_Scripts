!		2D_Plate capaciator
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.20/W64 Lite
!		Script Ver. 1.02
!
!		Github : https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			Plate capaciator on page 52.


    TITLE 'Plate capacitor'

    VARIABLES
    	U,
        Q
        
    SELECT
        NGRID 2
	
    DEFINITIONS
        Lx=5      				Ly=5					! X and Y coordination
        
        Dist = 2				delDist = 0.1		! Distance betwean left and right cover
        Height = 4										! Height cover
    															!
                                                                
        eps						eps0 = 8.854e-12			eps2 = 4 			! 	Permeability
        
        E = Grad( U )		Ex = -dx( U )     				Ey= -dy( U )		!	2,9	/	p38
		D = eps * E																			!	1,42	/	p25
    
        ! Voltage
        Uair = 0
        							Ul = -1							Ur = 249				! Ul - Left cover		Ur - Right cover
                                    									Ulr = Ur - Ul			! Voltage diference betwean left and right cover
        
        ! Charge
        C = 0.1e-6

    EQUATIONS
        	U : Div( -eps * E ) = 0				! 	U : Div ( -eps * grad( U ) ) = 0
    	THEN
        	Q : Div( grad( Q ) / eps ) = 0 
         
    BOUNDARIES     
    	REGION 1	
        	eps = eps0
    	  		START "V0" ( -Lx , -Ly )  
						NATURAL( U ) = Uair
    	  				NATURAL( Q ) = tangential( grad( U ) )
    	                        LINE TO ( Lx , -Ly ) TO ( Lx , Ly ) TO ( -Lx , Ly ) TO CLOSE
                                
		! Left Cover
			START "Left" ( -dist / 2 , height / 2 ) 
      		  		VALUE( U ) = Ul
                    VALUE( Q ) = -C * Ulr
							LINE TO ( -dist / 2 -delDist , height / 2 ) LINE TO ( -dist / 2 -delDist , -height / 2 ) LINE TO ( -dist / 2 , -height / 2 ) TO CLOSE

		! Right Cover
		START "Right" ( dist / 2 , height / 2 ) 
        			VALUE( U ) = Ur 
                    VALUE( Q ) = C * Ulr 
							LINE TO ( dist / 2 +delDist , height / 2 ) LINE TO ( dist / 2 +delDist , -height / 2 ) LINE TO ( dist / 2 , -height / 2 ) TO CLOSE     
		
        ! Betwean Covers 
        REGION 2 
    		eps= eps2
            	START ( -dist / 2 , -height / 2 ) LINE TO ( dist / 2 , -height / 2 ) LINE TO ( dist / 2  , height / 2) LINE TO ( -dist / 2 , height / 2 ) TO CLOSE        
 
    MONITORS				
        CONTOUR( U )
        CONTOUR( Q )

    PLOTS
    	CONTOUR( U )	painted	as 'Potential u'							! Painted is better looks like - I think so...
    	VECTOR( -E ) 	norm 		as 'Vector of electric field'			! Minus because from higher to lower voltage   
        
        FIELDMAP( U ) on "right"						fieldlines=40	points=400	as "Line of electric field"								! Line of Electric field
      	CONTOUR FIELDMAP( U ) on "left" 		fieldlines=40 	points=400 	as "Potential and Field Map - Left cover"		! Left or Ritght give a this same result
    	
       ELEVATION( D ) FROM ( 0 , Ly ) TO ( 0, -Ly )					! 
       
       SUMMARY
       		REPORT("Permeability: ")
    		REPORT( eps0 ) as "eps0 "
            REPORT( eps2 ) as "eps2 "
            REPORT(" ")
            REPORT("Voltage: ")
            REPORT( Ul ) as "Potential on left cover"
            REPORT( Ur ) as "Potential on right cover"
            REPORT( Ulr ) as "Voltage on capaciator"
    END
    