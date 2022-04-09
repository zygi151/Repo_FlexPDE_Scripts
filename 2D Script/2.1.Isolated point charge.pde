!		2D Isolated point charge
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.20/W64
!		Script Ver. 1.00
!
!		Github : https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			The script demonstrate a isolated point charge and his equipotential line
!			p.36


TITLE 											         
   'Isolated point charge'
   
SELECT								{  }
   spectral_colors				{ start at red end at violet }
   
DEFINITIONS                       
{ const }
   Lx = 1     		Ly = 1     		{ x and y coordinate }		{  [ unit ]  }
   q = 1e-5 							{ value of Q } 					{  [ C ]  }
   r0 = 1e-2        d0 = r0 * 2	{  }								   	{  [ unit ]  }
   
{ const }
   eps0= 8.85e-12     			{ perm. conductiwity } 	{  [ F / m ]  }
   
   k= 1 / ( 4 * pi * eps0 )		{ const k } 						{  [ m^2 / c^2 ]  }
   
   V= q * k / sqrt( x^2 + y^2 )	{ Potencjal }
   
   E= -grad( V )     			    { Gradient }
   Em= magnitude( E )         { Magnitude of vector }
   
BOUNDARIES
	REGION 'Uklad odniesienia'
	   start( -Lx , -Ly )  line to ( Lx , -Ly ) to ( Lx , Ly )  to ( -Lx , Ly ) close   
   
PLOTS
   { zoomed }
   contour( Em ) log painted as 'Value of potentia1l' 		zoom( 0, 0, d0 )	png
   contour( Em ) log 				as 'equipotential line' 		zoom( 0, 0, d0 )	png

   contour( E / Em )				as 'charge line'  												png
   vector( E / Em ) 				as 'Vector E' 						zoom( 0, 0, d0 )	png
   
{ make more a .png image - not zoomed }
		contour( Em ) log painted 	as 'Rozklad potencjalu' 		png
		contour( Em ) log 				as 'linie ekwipotencjalne' 	png
        contour( E/Em ) 					as 'charge line'					png
		vector( E/Em ) 					as 'Kierunek wektora E' 		png

SUMMARY as 'Data'
     report ( 'const:' )
     report( q ) 			as 'Q [ C ]'
     report( eps0 ) 	as 'perm. epsilon'
     report( k ) 			as 'k [ (N*m^2) / (C^2) ] '  
END

