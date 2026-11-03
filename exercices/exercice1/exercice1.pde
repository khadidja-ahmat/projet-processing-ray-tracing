void setup(){
  size(600, 500);//la taille de la fenetre
  loadPixels();
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      int indice = i +  j * width;
      float x = map(i, 0, width, 0, 1);
      float y = map(j, 0, height, 0, 1);
      float z = 0;
      pixels[indice] = color(x * 255, y * 255, z*255);
    }
  }
  updatePixels();
  save("image1.png");
}
