Camera camera; 
void setup() {
  size(600, 500);
  
    // initialisation de la caméra avec les dimensions de la fenêtre et un champ de vision de 90 degrés
  camera = new Camera(width, height, 90);
  loadPixels();
    // Parcourt de chaque pixel de la fenêtre
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int indice = x + y * width;
      Rayon rayon = camera.generateRay(x/float(width-1), y/float(height-1));
      float r = (rayon._direction.x + 1.0f) * 0.5f; 
      float g = (rayon._direction.y + 1.0f) * 0.5f; 
      float b = (rayon._direction.z + 1.0f) * 0.5f;  
      pixels[indice] = color(r * 255, g * 255, b * 255);
    }
  }
  updatePixels(); // Mettre àjour les changements aux pixels de la fenêtre
}
