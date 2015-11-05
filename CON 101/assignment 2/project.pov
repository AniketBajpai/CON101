//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <20 , 6.5 ,17.0>
                            right     x*image_width/image_height
                            look_at   <8.0 , 2.0 , 0.0>}

camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,2500,0> color White}

// sky -------------------------------------------------------------- 
#declare T_Clouds  =
texture {
    pigment { bozo
        turbulence 1.5
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.0 color rgbf<1, 1, 1, 1> ]
                    [0.2 color rgbf<0.85, 0.85, 0.85, 0.00>*1.5 ]
                    [0.5 color rgbf<0.95, 0.95, 0.95, 0.90>*1.12  ]
                    [0.6 color rgbf<1, 1, 1, 1> ]
                    [1.0 color rgbf<1, 1, 1, 1> ] }
    }

    finish {ambient 0.95 diffuse 0.1}
}

//--------------------------------------------------------------------
union { // make sky planes: 

 plane { <0,1,0>, 500 hollow //!!!!
        texture { bozo scale 1
                  texture_map{ 
                       [ 0.0  T_Clouds ]
                       [ 0.5  T_Clouds ]
                       [ 0.6  pigment{color rgbf<1,1,1,1> }] 
                       [ 1.0  pigment{color rgbf<1,1,1,1> }] 
                      } 
                       scale <500,1,1000>} translate<-400,0,300> } 

 plane { <0,1,0> , 10000  hollow
        texture{ pigment {color rgb<0.24,0.38,0.7>*0.50}
                 finish {ambient 1 diffuse 0}}}
scale<1.5,1,1.25>  
rotate<0,0,0> translate<0,0,0>}                          // end of sky
//--------------------------------------------------------------------

     
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane        
      


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/* 
// alternative declaration of textures
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
*/
//-------------------------------------------------------------------------------------// 
#include "Street_00.inc" 
#include "Street_10.inc"  // street with center stripes with continuous border lines
#include "Street_Curve_10.inc" // curved street with middle stripes 
//-------------------------------------------------------------------------------------// 
object{ Street_10( 4,     // Street_Widthm, // 
                   70 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length                                  
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, -65.00>}
//-------------------------------------------------------------------------------------// 
object{ Street_Curve_10( 4.00,  // Street_Widthm, // 
                        30,    // Curve_Angle,   // degrees, right handed
                        30.00,  // Curve_Radius,  // 
                        0.10,  // Stripes_Width, // 
                        1.00,  // Stripes_Length                                  
                      ) //-------------------------------------------------------------//
        scale <1,1,1>*1 // curve to the right by "scale<-1,1,1>"
        rotate<0,0,0> 
        translate<0.00,0.00, 5.00>}
//-------------------------------------------------------------------------------------// 
object{ Street_10( 4,     // Street_Widthm, // 
                   100 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length // = 0 => continuous line!!!                                 
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        translate<30.00,0.00,0.00>  rotate<0,-30,0>  translate<-30.00,0.00,0.00> 
        translate<0.00,0.00, 5.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
union{ 
//-------------------------------------------------------------------------------------// 
object{ Street_10( 4,     // Street_Widthm, // 
                   70 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length                                  
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, -65.00>}
//-------------------------------------------------------------------------------------// 
object{ Street_Curve_10( 4.00,  // Street_Widthm, // 
                        30,    // Curve_Angle,   // degrees, right handed
                        30.00-4,  // Curve_Radius,  // 
                        0.10,  // Stripes_Width, // 
                        1.00,  // Stripes_Length                                  
                      ) //-------------------------------------------------------------//
        scale <1,1,1>*1 // curve to the right by "scale<-1,1,1>"
        rotate<0,0,0> 
        translate<0.00,0.00, 5.00>}
//-------------------------------------------------------------------------------------// 
object{ Street_10( 4,     // Street_Widthm, // 
                   100 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length // = 0 => continuous line!!!                                 
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        translate<30.00-4,0.00,0.00>  rotate<0,-30,0>  translate<-30.00+4,0.00,0.00> 
        translate<0.00,0.00, 5.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
 translate<-4.00,0.00, 0.00>}


//-------------------------------------------------------------------------------------// 
object{ Street_00( 4,     // Street_Widthm, // 
                   100 , // Street_Length, //
                   0.15,  // Stripes_Width, // 
                   1.00,  // Stripes_Length // = 0 => continuous line!!!                                 
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
          rotate<0,90,0>   
        translate<2.00-0.20,0.002, 5.00>}
//-------------------------------------------------------------------------------------// 

#declare Wall_Texture_Outside = 
      texture { pigment{ color White*1.1}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Wall_Texture_Inside = 
      texture { pigment{ color White*1.1}
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color Scarlet*1.3}
                normal { gradient z scallop_wave scale<1,1,0.15>} 
                finish { phong 1}
              } // end of texture
 
      texture { pigment{ gradient x 
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture

//--------------------------------------------------------
#declare Window_Texture = 
         texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.35 } // brown  
                  // pigment{ color White*1.2}
                  finish { phong 0.1}}
//--------------------------------------------------------------------------------------- 
//---------------------------------------------------------------------------------------
#include "House_1_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ House_1_0(  2.50, // Half_House_Width_X, // >= 2.00
                    5.50, // Total_House_Width_Z,// >= 2.00
                    3.50, // House_Height_Y,     // >= 2.00
                    25,   // Roof___Angle, // ca. 10 ~ 60 degrees
                      
                    Wall_Texture_Outside
                    Wall_Texture_Inside 
                    Window_Texture                                                    
                    Roof_Texture
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1.5
        rotate<0,130,0> 
        translate<13.00,0.00, -4.00>}

//---------------------------------------------------------------------------------------

//--------------------------------------------------------------------------
// tree textures: ---------------------------------------
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.25 } 
          normal { bumps 0.75 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//------------------------------------------------------- 
#declare Leaves_Texture_1 = 
 texture{ pigment{ bozo 
                   color_map{
                   [0.0 color rgbf< 1,0.1,0.0, 0.2>*0.7 ]  
                   [1.0 color rgbf< 1,0.7,0.0, 0.2>*1 ]
                            } //color_map  
                 }  // pigment 
          normal { bumps 0.15 scale 0.05 }
          finish { phong 1 reflection 0.00}
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_2 = 
 texture{ pigment{ color rgbf< 1,0.5,0.0, 0.4>*0.5}    
          normal { bumps 0.15 scale 0.05 }
          finish { phong 0.2 }
        } // end of texture 
//-------------------------------------------------------- 
//--------------------------------------------------------------------------
#include "sassafras_m.inc"
//#declare Tree_Height = sassafras_13_height; // ~23.29, not used here!
//--------------------------------------------------------------------------
// tree with leaves
   union{ 
          object{ sassafras_13_stems
                  texture{ Stem_Texture }
                } //------------------------
          object{ sassafras_13_leaves  
                  double_illuminate
                  texture{ Leaves_Texture_1 }   
                  interior_texture{ Leaves_Texture_2 }   
                } //------------------------
      rotate <0,90,0>
      translate<6,0,-3>
    } // end of union 
//--------------------------------------------------------------------------

















