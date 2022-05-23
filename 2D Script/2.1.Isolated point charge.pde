!		2D Isolated point charge
!		
!		Mail : dawid151@gmail.com			! Mail to me if you see something wrong in this script
!		
!		FlexPDE Ver. V.7.20/W64
!		Script Ver. 1.02
!
!		Github : https://github.com/zygi151/Repo_FlexPDE_Scripts
!
!		Description:
!			The script demonstrate a isolated point charge and his equipotential line
!			p.36


TITLE 											         
   'Isolated point charge'
   
SELECT									{  it was unnecessary }
   spectral_colors					{ start at red end at violet }
   
DEFINITIONS                     		{ const / var }
   Lx = 1     		Ly = 1     			{ x and y coordinate }		{  [ unit ]  }
   q = 1e-5 								{ value of Q } 					{  [ C ]  }
   r0 = 1e-2     					   	 	{  }								   	{  [ unit ]  }
   d0 = r0 * 2							{  }								   	{  [ unit ]  }
   eps0 = 8.85e-12     				{ perm. conductivity } 		{  [ F / m ]  }
   k = 1 / ( 4 * pi * eps0 )			{ const k  } 						{  [ m^2 / c^2 ]  }
   V = q * k / sqrt( x^2 + y^2 )	{ Potential }
   
   E= -grad( V )       			    	{ Gradient }
   Em = magnitude( E )         	{ Magnitude of vector }
   
BOUNDARIES
	REGION 'Frame'
	   START( -Lx , -Ly )  line to ( Lx , -Ly ) to ( Lx , Ly )  to ( -Lx , Ly ) close   
   
PLOTS
{ Not zoomed }																			
		CONTOUR( Em ) log painted 	as 'Potential' 						png			! PNG - make a photo on .png format
		CONTOUR( Em ) log 				as 'Equipotential line' 		png			
        CONTOUR( E/Em ) 					as 'Charge line'					png			
		VECTOR	 ( E/Em ) 					as 'Direction of vector E' 	png			
        
																													{ The layout has a symetry then it posibly to show a quater of plots using zoom functions}
{ zoomed }
   CONTOUR( Em ) log painted 		as 'Potential - zoom' 						zoom( 0, 0, d0 )	png	! PNG - make a photo on .png format
   CONTOUR( Em ) log 					as 'Equipotential line - zoom' 		zoom( 0, 0, d0 )	png
   CONTOUR( E / Em )						as 'Charge line - zoom'  				zoom( 0, 0, d0 )	png
   VECTOR	( E / Em ) 					as 'Direction of vector E - zoom' 	zoom( 0, 0, d0 )	png
   
SUMMARY as 'Data'	
{ Raporting of some value }
     report ( 'const:' )
     report( q ) 									as 'Q [ C ]'
     report( eps0 ) 							as 'epsilon - permament conductivity'
     report( k ) 									as 'k [ (N*m^2) / (C^2) ] '  
END

