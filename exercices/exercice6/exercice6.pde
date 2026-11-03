ArrayList<Sphere> spheres;  // Liste pour stocker les sphères 
Sphere spherePrincipale;  // La sphère principale située au centre

void setup() { 
  size(600, 500);  
  Camera camera = new Camera(width, height, 90);  
  // les position des sphères
 PVector[] positionsSpheresBoite = { 
  new PVector(-505, 0, 0),  
  new PVector(505, 0, 0),   
  new PVector(0, -505, 0),  
  new PVector(0, 505, 0),  
  new PVector(0, 0, -510),  
  new PVector(0, 0, 510)    
}; 

// les couleurs des  sphères
PVector[] couleursSpheresBoite = { 
  new PVector(255, 0, 0),    
  new PVector(0, 0, 255),    
  new PVector(255, 0, 255),  
  new PVector(255, 255, 0),  
  new PVector(0, 255, 255),  
  new PVector(0, 255, 0)     
}; 

// la position et la couleur de la sphère principale
PVector positionSpherePrincipale = new PVector(0, 0, 4);  
PVector couleurSpherePrincipale = new PVector(255, 255, 255); 

// Position de la source lumineuse
PVector sourceLumiere = new PVector(-1, 2, -0.5); 

int nombreSpheresBoite = 6;  
float rayonSpherePrincipale = 1.2;  
float rayonSpheresBoite = 500;  
float distanceMaximale = 1000; 
float distanceMinimale = 0.0001;  

  // initialisation de la sphère principale et de la liste des sphères
  spherePrincipale = new Sphere(positionSpherePrincipale, rayonSpherePrincipale, couleurSpherePrincipale); 
  spheres = new ArrayList<Sphere>();
  // l'ajout de la sphère principale à la liste
  spheres.add(spherePrincipale);  

  // l'ajout des grandes sphères formant une boîte autour de la sphère blanche
  for (int i = 0; i < nombreSpheresBoite; i++) { 
   spheres.add(new Sphere(positionsSpheresBoite[i], rayonSpheresBoite, couleursSpheresBoite[i])); 
  }

  loadPixels(); 
  for (int x = 0; x < width; x++) { 
    for (int y = 0; y < height; y++) { 
      int indice = x + y * width;
      
     Rayon rayon = camera.generateRay(x / (float)(width - 1), y / (float)(height - 1));

      float distancePlusProche = -1;  
      float distanceCourante = 0;  
      Sphere spherePlusProche = null; 

      // la vérification des intersections avec toutes les sphères
      for (Sphere sphere : spheres) { 
        distanceCourante = sphere.intersect(rayon, distanceMinimale, distanceMaximale); 
        if (distanceCourante != -1 && (distancePlusProche == -1 || distanceCourante < distancePlusProche)) { 
          distancePlusProche = distanceCourante;  
          spherePlusProche = sphere;  
        } 
      }

      // si une intersection est trouvée
      if (spherePlusProche != null) { 
        
        // le calcul du point d'intersection entre le rayon et la sphère
        PVector pointIntersection = PVector.add(rayon._origine, PVector.mult(rayon._direction, distancePlusProche));  
        
        // le calcul de la direction de la lumière 
        PVector directionLumiere = PVector.sub(sourceLumiere, pointIntersection).normalize();  
        
        // le calcul de la surface normale à la sphère au point d'intersection
        PVector normaleSurface = PVector.sub(pointIntersection, spherePlusProche.centre).normalize();  
        
        // le calcul de l'intensité lumineuse 
        float intensiteLumiere = PVector.dot(normaleSurface, directionLumiere);  

        // vérification de l'ombre (si le point est en ombre)
        boolean estEnOmbre = false; 
        Rayon rayonOmbre = new Rayon(pointIntersection, directionLumiere);  
        for (Sphere sphere : spheres) { 
          if (sphere != spherePlusProche) {  
            float distanceOmbre = sphere.intersect(rayonOmbre, distanceMinimale, distanceMaximale); 
            estEnOmbre = (distanceOmbre != -1 && distanceOmbre < PVector.dist(pointIntersection, sourceLumiere)); 
            if (estEnOmbre) break;  // Arrêter si une ombre est détectée
          } 
        }

        // Calcul de la couleur finale en fonction de l'éclairage
        PVector couleurFinale = new PVector(); 
        if (!estEnOmbre && intensiteLumiere > 0) { 
          couleurFinale = PVector.mult(spherePlusProche.couleur, intensiteLumiere); 
        } 

        pixels[indice] = color(couleurFinale.x, couleurFinale.y, couleurFinale.z); 
      } 
    } 
  } 
  updatePixels();
}
