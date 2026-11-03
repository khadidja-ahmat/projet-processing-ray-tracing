Sphere sphere; 
void setup() {
  size(600, 500); 
  Camera camera = new Camera(width, height, 90); 
  
  // la création d'une sphère blanche positionnée à (0, 0, 4) avec un rayon de 1
  sphere = new Sphere(new PVector(0, 0, 4), 1.5f, new PVector(1, 1, 1)); 

  loadPixels(); 

  // parcours de chaque pixel de l'image
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int indice = x + y * width; 

      Rayon rayon = camera.generateRay(x / (float)(width - 1), y / (float)(height - 1));
      float t = sphere.intersect(rayon, 0.001f, 1000.0f);

      if (t > 0) {
        // si une intersection est trouvée, on va colorer le pixel avec la couleur de la sphère
        pixels[indice] = color(sphere.couleur.x * 255, sphere.couleur.y * 255, sphere.couleur.z * 255);
      } else {
        // sinon, on vas appliqué une couleur d'arrière-plan
        pixels[indice] = color(0.8f * 255, 0.8f * 255, 0.8f * 255);
      }
    }
  }

  updatePixels(); 
}
