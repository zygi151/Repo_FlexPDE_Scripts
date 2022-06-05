!		2D_Layered plate capaciator
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.20 / W64 3D
!		Script Ver. 0.01
!
!		Github : https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			Show plate capaciator witch layers
!			p.53
! TO DO :
!	wykasowac capaDist /2 - + capaDist bo zle wyglada

    TITLE 'Layered plate capacitor'

    VARIABLES
    	U
        
        
    SELECT
        NGRID 2
	
    DEFINITIONS
        Lx=3      				Ly=3						! X and Y coordination
        
        Dist = 1.2				delDist = 0.1		! Distance betwean left and right cover
        Height = Ly											! Height cover
    	
        ! Do not change this
       		 capaLayer = 3														
        	 capaDist = Dist / capaLayer ! 
                                                                
        eps						eps0 = 8.854e-12			
        eps1 = eps0	! air	
        eps2 = 4			! Layer 1
        eps3 = 1			! Layer 2        
        eps4 = 2	 		! Layer 3
        
        E = grad( U )		Ex = -dx( U )     				Ey= -dy( U )		!	2,9	/	p38
		D = eps * E																			!	1,42	/	p25
    
        ! Voltage
        Uair = 0
        							Ul = 1							Ur = -1					! Ul - Left cover		Ur - Right cover
                                    									Ulr = Ur - Ul			! Voltage diference betwean left and right cover
        
        ! Charge
        C = 0.1e-6

    EQUATIONS
        	U : Div( D ) = 0				! 	U : Div ( -eps * grad( U ) ) = 0
    	
    BOUNDARIES     
    	REGION 1	
        	eps = eps1
    	  		START "V0" ( -Lx , -Ly )  
						NATURAL( U ) = Uair
    	  				!NATURAL( Q ) = tangential( grad( U ) )
    	                        LINE TO ( Lx , -Ly ) TO ( Lx , Ly ) TO ( -Lx , Ly ) TO CLOSE
                                
		! Left Cover
			START "Left" ( -dist / 2 , height / 2 ) 
      		  		VALUE( U ) = Ul
                    !VALUE( Q ) = -C * Ulr
							LINE TO ( -dist / 2 -delDist , height / 2 ) LINE TO ( -dist / 2 -delDist , -height / 2 ) LINE TO ( -dist / 2 , -height / 2 ) TO CLOSE

		! Right Cover
		START "Right" ( dist / 2 , height / 2 ) 
        			VALUE( U ) = Ur 
                    !VALUE( Q ) = C * Ulr 
							LINE TO ( dist / 2 +delDist , height / 2 ) LINE TO ( dist / 2 +delDist , -height / 2 ) LINE TO ( dist / 2 , -height / 2 ) TO CLOSE     
		
        ! Layers 
        REGION 2 		eps= eps2
            					START ( -capaDist / 2 , -height / 2 ) LINE TO ( capaDist / 2 , -height / 2 ) LINE TO ( capaDist / 2  , height / 2) LINE TO ( -capaDist / 2 , height / 2 ) TO CLOSE       
        REGION 3 		eps= eps3
            					START ( -capaDist / 2  , -height / 2 ) LINE TO ( -capaDist / 2 -capaDist , -height / 2 ) LINE TO ( -capaDist / 2 -capaDist  , height / 2) LINE TO ( -capaDist / 2 , height / 2 ) TO CLOSE        
        REGION 4  		eps= eps4
            					START ( capaDist / 2  , -height / 2 ) LINE TO ( capaDist / 2 +capaDist , -height / 2 ) LINE TO ( capaDist / 2 +capaDist  , height / 2) LINE TO ( capaDist / 2 , height / 2 ) TO CLOSE        
                
    MONITORS				
        CONTOUR( U )
        !CONTOUR( Q )

    PLOTS
    	CONTOUR( U )	painted	as 'Potential u'							! Painted is better looks like - I think so...
    	VECTOR( E ) 	norm 		as 'Vector of electric field'			! Minus because from higher to lower voltage   
        
        FIELDMAP( U ) on "right"						fieldlines=40	points=400	as "Line of electric field"								! Line of Electric field
      	CONTOUR FIELDMAP( U ) on "left" 		fieldlines=40 	points=400 	as "Potential and Field Map - Left cover"		! Left or Ritght give a this same result
    	
       !ELEVATION( D ) FROM ( 0 , Ly ) TO ( 0, -Ly )					! 
       elevation( E ) from ( -dist/2, 0 ) to ( dist/2 , 0 )
       elevation( D ) from ( -dist/2, 0 ) to ( dist/2 , 0 )
       elevation( u ) from ( -dist/2, 0 ) to ( dist/2 , 0 )
       
       !elevation( value(U) ) from ( -dist/2, 0 ) to ( dist/2 , 0 )
       
       
       SUMMARY
       		report("Permeability: ")
    		report( eps0 ) as "eps0 "
            report( eps1 ) as "L1 eps "
            report( eps2 ) as "L2 eps "
            report( eps3 ) as "L3 eps "
            
            report(" ")
            report("Voltage: ")
            report( Ul ) as "Potential on left cover"
            report( Ur ) as "Potential on right cover"
            report( Ulr ) as "Voltage on capaciator"
    END
    