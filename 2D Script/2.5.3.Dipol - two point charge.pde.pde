!		2D_Two point charge
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Lite Ver. V.7.20/W64 3D
!		Script Ver. 1.09
!
!		Description:
!			Scripts show electrostatic field around electric dipol

TITLE 								         
   'Electrostatic field around two elementary point '	
      
DEFINITIONS                              	{ Definicion of const and variable }
   Lx 	= 5e-1     	  							{ study space - long and heigh - x,y coordination }	{ 	[ unit ] } 
   Ly 	= 5e-1     				
   
   eps0 = 8.85e-12     						{ electric permament } 												{	[ F / m ] }
   k 		= 1 / ( 4 * pi * eps0 )			{ const k - use for clarity potential equations} 			{	[ m ^ 2 / c ^ 2 ] }
   
   r0 = 5e-2										{ radius of a charge point  }	   									{ 	[ unit ] }
   dist = 7e-2									{ distance betwean point } 											{ 	[ unit ] }
   
   centerDist	= dist /2					{ distance of the center of the coordinate axes }		{ 	[ unit ] }
   q0					= 1e-5
   
   {------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
 							sign1 	= +1																sign2 	= -1																{ sign of point charge / multiplier	}
   	 						q1		= sign1 * q0 												q2		= sign2 * q0 												{ value of point charge  				 	}
    						r1 		= sqrt ( ( x + centerDist ) ^ 2 + y ^ 2)			r2 		= sqrt ( ( x -  centerDist ) ^ 2 + y ^ 2)			{ radius of each point 						}
  							v1 		= k * q1 / r1													v2 		= k * q2 / r2													{ potential of each point 					}
  {-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
  
  U = v1 + v2					! Superposition of potential
  E = -grad ( U )				! Gradient 
  Em = magnitude( E )		! Magnitude of gradient
   
BOUNDARIES
	REGION 'space'
		START( -Lx , -Ly )  LINE TO ( Lx , -Ly ) TO ( Lx , Ly ) TO ( -Lx , Ly ) TO CLOSE   
        
        ! use to the next script
                !START 'left' (  centerDist  , r0 ) 			ARC ( CENTER =  centerDist , 0 ) 	ANGLE = 360	{ left point }
    			!START 'right' ( -centerDist  , r0 ) 		ARC ( CENTER = -centerDist , 0 ) 	ANGLE = 360	{ right point }	
   
PLOTS
	SURFACE( U )														AS ' potential U' 						{ a little pick up, and down. It was elementary point }
    
    !CONTOUR( U ) 													AS ' potential U' 						{ For my opinion painted contour looks beter }
    CONTOUR( U ) painted 										AS ' potential U' 
    
   	ELEVATION	( U ) FROM ( -Lx , 0 ) TO ( Lx , 0 ) 	AS ' value of potential '

	VECTOR( E / Em ) 												AS 'direction of vector'		{ this plot show two vector on one plot, for + / + value }
    VECTOR( E / Em ) 												AS 'direction of vector - zoom closed' 		ZOOM( -dist , -centerDist , dist * 2  , dist )	

SUMMARY as 'Data:'
     report ( 'const : ' )
        report( eps0 ) as 'epsilon '
     	report( k ) as 'k [ ( N * m ^ 2 ) / ( C ^ 2 ) ] '  

     	report(' ') { new line - only for better view }
     	report( q1 ) as 'Q1 [ C ] '
     	report( q2 ) as 'Q2 [ C ] '
END
