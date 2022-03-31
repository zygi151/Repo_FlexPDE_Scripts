!		2D_Two point charge
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.18/W64
!		Script Ver. 1.00
!
!		Description:
!			

TITLE 								         
   'Pole elektrostatyczne ladunku punktowego'	
   
SELECT
   spectral_colors						{ Kolory od czerwonego do fioletu }
   
DEFINITIONS                               { Definicja }
{ zmiennych }
   Lx= 2     		Ly= 2     				{ dlugosc / szerokosc }	{ [ m ] }
   q= 1e-5 									{ ladunek q } 					{ [ C ] }
   r0= 0.1        d0= r0 * 2				{ promien / srednica }	   	{ [ m ] }
   
{ stalych }
   eps0= 8.85e-12     		{ przenikalnosc elektryczna } { [F/m] }
   k= 1 / ( 4*pi*eps0 )		{ stala k } 	{ [m^2 / c^2] }
   
   q1= 3e-7						{ ladunek q1 } { [ C ] }
   q2= 3e-7 {2e-5}						{ ladunek q2 } { [ C ] }
   
   U1= q1*k / sqrt( (x -1.5)^2 + y^2 )	{ potencjal }
   U2= q2*k / sqrt( (x+1.5)^2 + y^2 )
   
   U= U1+U2
   
   E= -grad(U)     				Em=magnitude(E)           
   D = -grad(U*eps0)	   	Dm = magnitude ( D ) 
   
   
BOUNDARIES

region 'uklad odniesienia'
   start(-Lx,-Ly)  line to (Lx,-Ly) to (Lx,Ly)  to (-Lx,Ly) close   
   
	start( -1.5 - r0, d0) arc( center = -1.5, 0 ) angle=360	
    start( 1.5 + r0, d0) arc( center= 1.5,0 ) angle=360
   
PLOTS
   contour( E) painted
   contour( dy(E/em) ) 
   contour( u1/em ) 
   contour( ( u1/magnitude(-grad(u1)) + u2/magnitude( - grad(u2) ) ) ) 
   
   !contour( -dy(E/em)*q2 ) 
   !contour( -dx(E/em)*q2 ) 
   vector( U1 / magnitude ( -grad(U1) ) )  
   vector( U2 / magnitude(-grad(U2)) )
   
   vector ( u1/magnitude(-grad(u1)) + u2/magnitude( - grad(u2)))
   
   vector( -E/Em ) as 'Kierunek wektora E'
   vector(E/Em*q1*(-1))
   elevation( magnitude(E) ) from (-2, 0) to ( 2,0)
   elevation( E ) from (-2, 0) to ( 2,0)

SUMMARY as 'Dane zadania'
     report ( '1e-1 = 1*10^(-1)' )
     report ( 'stale:' )
     report( q ) as 'Q [C]'
     report( eps0 ) as 'Epsilon '
     report( k ) as 'k [ (N*m^2) / (C^2) ] '  
     report( val(Em, 0,0) )
     report( val(Em*q2, 0,0) )
     report(q1)
     report(q2)
     report( q1*q2)
     report( k * q1*q2  )
     report( k * q1*q2 / (0.3^2) )
     
     
END

