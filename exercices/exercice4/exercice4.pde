ArrayList<Sphere> spheres; // liste pour stocker les sphères 

void setup() {
  size(600, 500); 
  Camera camera = new Camera(width, height, 90); 

  // initialisation de la liste de sphères
  spheres = new ArrayList<Sphere>();

  // l'ajout de la sphère au centre
  spheres.add(new Sphere(new PVector(0, 0, 4), 1.5f, new PVector(1, 1, 1))); 

    // l'ajout des grandes sphères formant une boîte autour de la sphère blanche  
  spheres.add(new Sphere(new PVector(0, 0, -510), 500.0f, new PVector(0, 1, 1))); //pour la couleur cyan
  spheres.add(new Sphere(new PVector(0, 0, 510), 500.0f, new PVector(0, 1, 0)));  // pour la couleur verte  
  spheres.add(new Sphere(new PVector(0, 505, 0), 500.0f, new PVector(1, 1, 0)));  // pour la couleur jaune  
  spheres.add(new Sphere(new PVector(505, 0, 0), 500.0f, new PVector(0, 0, 1)));  // pour la couleur bleue 
  spheres.add(new Sphere(new PVector(-505, 0, 0), 500.0f, new PVector(1, 0, 0))); // pour la couleur rouge 
  spheres.add(new Sphere(new PVector(0, -505, 0), 500.0f, new PVector(1, 0, 1))); // pour la couleur magenta

  loadPixels(); 
  // Parcourt de chaque pixel 
  for (int x = 0; x < width; x++) { 
    for (int y = 0; y < height; y++) { 
      int indice = x + y * width; 
      Rayon rayon = camera.generateRay(x / (float)(width - 1), y / (float)(height - 1));

      //initialisation des variables pour trouver la sphère la plus proche
      float distanceMin = Float.MAX_VALUE;
      PVector couleur = new PVector(0.8f, 0.8f, 0.8f); 
      for (Sphere sphere : spheres) {
        float t = sphere.intersect(rayon, 0.001f, distanceMin); 
        if (t > 0 && t < distanceMin) { 
          distanceMin = t; 
          couleur = sphere.couleur; 
        }
      }

      pixels[indice] = color(couleur.x * 255, couleur.y * 255, couleur.z * 255);
    }
  }
  updatePixels(); 
}
