import processing.video.*;
PShader dithering;
PImage  source, noise;
Capture cam;
void setup() {
  
  size( 640,480, P2D );
  cam= new Capture(this,width,height);
  cam.start();
  source  = null;
  noise  = loadImage( "noise.png" );
  
  dithering=loadShader( "shaders1.glsl" );
  dithering.set("sketchSize", float(width), float(height));
  dithering.set("noiseTexture", noise);
}


void draw() {
  if(cam.available() && !mousePressed){
    background(0);
    cam.read();
    source  =cam.copy();
    image( source, 0, 0 );
    filter( dithering );
    resetShader();
  }else if (cam.available()){
    cam.read();
    image( cam.copy(), 0, 0 );
  }
  

  

}
