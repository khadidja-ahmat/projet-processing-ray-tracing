ArrayList<Sphere> spheres; // liste pour stocker les sphères 
PVector sourceLumiere; // source de la lumière

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

  
  // initialisation de la position du source lumineuse
  sourceLumiere = new PVector(-1, 2, -0.5);

  loadPixels(); 
  
  // Parcourt de chaque pixel de l'image
  for (int x = 0; x < width; x++) { 
    for (int y = 0; y < height; y++) { 
      int indice = x + y * width;  

      Rayon rayon = camera.generateRay(x / (float)(width - 1), y / (float)(height - 1));

      // initialisation des variables pour trouver la sphère la plus proche
      float distanceMin = Float.MAX_VALUE; 
      PVector couleur = new PVector(0.8f, 0.8f, 0.8f);

      // le parcours chaque sphère pour tester les intersections
      for (Sphere sphere : spheres) {
        float t = sphere.intersect(rayon, 0.001f, distanceMin); 
        if (t > 0 && t < distanceMin) {
          distanceMin = t; 

          // le calcul du point d'intersection entre le rayon et la sphère
          PVector pointIntersection = PVector.add(rayon._origine, PVector.mult(rayon._direction, t));

          // le calcul de la surface normale à la sphère au point d'intersection
          PVector normaleSurface = PVector.sub(pointIntersection, sphere.centre).normalize();

          // le calcul de la direction de la lumière 
          PVector directionLumiere = PVector.sub(sourceLumiere, pointIntersection).normalize();

          // le calcul de l'intensité lumineuse 
          float intensiteLumiere = max(0, normaleSurface.dot(directionLumiere));
          couleur = PVector.mult(sphere.couleur, intensiteLumiere);
        }
      }
      pixels[indice] = color(couleur.x * 255, couleur.y * 255, couleur.z * 255);
    }
  }
  updatePixels(); 
}
