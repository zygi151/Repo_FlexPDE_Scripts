!		2D_Two point charge
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.18/W64
!		Script Ver. 1.00
!
!		Description:
!			Scripts show electrostatic field around 2 charge point

TITLE 								         
   'Electrostatic field around two charge point'	
   
SELECT
 !  spectral_colors						{ red to violet colour }
   
DEFINITIONS                               { Definicion of variable }
{ const / variable }
   Lx = 2     	   Ly = 2     				{ long / height }						{ 	[ unit ] }
   r0 = 0.1        d0 = r0 * 2			{ radius / diameter }	   			{ 	[ unit ] }
   dist = 1.5									{ distance betwean points }	{ 	[ unit ] }
   
   eps0= 8.85e-12     				{ electric permament } 				{ [ F / m ] }
   
   k= 1 / ( 4*pi*eps0 )				{ const k } 									{ [ m ^ 2 / c ^ 2 ] }
   
   { Use this section to change value }		{ Things below using this to calculations }
   { =============================  }	{ for the change value of charge point use this }
   Q= 1e-5 													{ value of charge   } 							{ 	[ C ] }
        			sign1 = +1		factor1 = 1		{ sign / multiplier }
   					sign2 = - 1		factor2 = 1		{ sign / multiplier }   
   { Q1 and Q2 }
   				Q1= sign1 * Q * factor1						{ charge q1 } 								{ 	[ C ] }
   				Q2= sign2 * Q * factor2						{ charge q2 } 								{ 	[ C ] }
   { =============================  }
   
   { U1 and U2 }
   				{ potential }														{ vector }						{ magnitude of vector }	{ X-component }	{ Y-component }
   				U1= Q1 * k / sqrt( ( x + dist ) ^ 2 + y ^ 2 )			E1 = -grad( U1 )			Em1 = magnitude( E1 )	Ex1 = -dx( U1 )	Ey1 = -dy( U1 )		{ potencjal / gradient / magnitude / x-component / y-component for 	1 }		
   				U2= Q2 * k / sqrt( ( x -  dist ) ^ 2 + y ^ 2 )			E2 = -grad( U2 )			Em2 = magnitude( E2 )	Ex2 = -dx( U2 )	Ey2 = -dy( U2 )		{ potencjal / gradient / magnitude / x-component / y-component for 	2 }		
	
   U = U1 + U2														E = -grad( U )     			Em = magnitude( E )          	{ portential / gradient / agnitude for U1 + U2 }
   																			D = -grad( U * eps0 ) 	Dm = magnitude( D ) 		   	{ vector D / magnitude of vector D }
                                                                            
   Ea1 = sign(u1) * arccos( Ex1 / Em1 ) 			Ea2 = sign(u2) * arccos( Ex2 / Em2 ) 				Ea = Ea1 + Ea2	!	Thanks for this line, to the moderator of forum flexpde.
   
BOUNDARIES
	REGION 'frame of reference'
		START( -Lx , -Ly )  LINE TO ( Lx , -Ly ) TO ( Lx , Ly ) TO ( -Lx , Ly ) TO CLOSE   
   
   { position of points }
		START( + dist + r0 , d0 ) 		ARC ( CENTER = +dist , 0 ) 	ANGLE = 360	{ left charge }
    	START( -  dist -  r0 , d0 ) 		ARC ( CENTER = - dist , 0 ) 	ANGLE = 360	{ right charge }
   
{ plots }   
PLOTS
    CONTOUR	( U ) painted 								AS ' potential U'
   	!CONTOUR	( U ) 											AS ' potential U'
   	ELEVATION	( U ) from ( -Lx , 0 ) TO ( Lx , 0 ) 	AS ' value of potential '
    
    
    CONTOUR( Ea ) 											  	AS 'equipotential line '
    !VECTOR( E / Em ) 						AS 'direction of vector' 							! this plot show two vector on one plot, for + / + value 
    																													! theres mean the point balance eatch in center part, 
    																													! and not balnced on extreame left and right side therefore below plots is better to show dependence
   	VECTOR( E1 / Em1 + E2 /Em2 ) 						AS ' direction of vector'		! The vector shouldbe drawning on the equipotential line, but software cannot do this, then must show in 2 window	

SUMMARY as 'Data:'
     report ( 'const : ' )
     report( eps0 ) as 'Epsilon '
     report( k ) as 'k [ ( N * m ^ 2 ) / ( C ^ 2 ) ] '  
     
     report(' ') { new line - only for better view }
     report( q1 ) as 'Q1 [ C ] '
     report( q2 ) as 'Q2 [ C ] '
     
 	 report(' ') { new line - only for better view }
     report( val(Em, 0,0) )
     report( val(Em*q2, 0,0) )     
END

