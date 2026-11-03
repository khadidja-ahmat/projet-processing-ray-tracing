class Sphere {
  PVector centre; //centre de la sphère
  float rayon;    //rayon de la sphère
  PVector couleur; //couleur de la sphère

  Sphere(PVector centre, float rayon, PVector couleur) {
    this.centre = centre; 
    this.rayon = rayon;   
    this.couleur = couleur; 
  }

  float intersect(Rayon p_ray, float p_tMin, float p_tMax) {
    // Calcul du vecteur entre l'origine du rayon et le centre de la sphère
    PVector origine_centre = PVector.sub(p_ray._origine, centre);

    // Coefficients de l'équation quadratique : a, b, c
    float a = PVector.dot(p_ray._direction, p_ray._direction); 
    float b = 2.0f * PVector.dot(origine_centre, p_ray._direction); 
    float c = PVector.dot(origine_centre, origine_centre) - rayon * rayon; 

    // calcul de delta de l'équation ou du discriminant
    float delta = b * b - 4 * a * c;
    if (delta > 0) {
      // les deux solutions de l'équaltion sont x1 et x2
      float x1 = (-b - (float)Math.sqrt(delta)) / (2.0f * a); 
      float x2 = (-b + (float)Math.sqrt(delta)) / (2.0f * a); 

      // condition de vérification de x1 et x2 s'ils sont bien dans l'intervalle [p_tMin, p_tMax]
      if (x1 >= p_tMin && x1 <= p_tMax) return x1; 
      if (x2 >= p_tMin && x2 <= p_tMax) return x2; 
    }

    // sinon
    return -1.0f;
  }
}
