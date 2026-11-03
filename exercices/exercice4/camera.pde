// All public for simplicity
class Camera
{
  Camera(int p_imgWidth, int p_imgHeight, float p_fov)
  {
    _position = new PVector(0.f, 0.f, 0.f);
    // The camera coordinate system (_u, _v, _w) is fixed in this exercise!
    _u = new PVector(1.f, 0.f, 0.f);
    _v = new PVector(0.f, 1.f, 0.f);
    _w = new PVector(0.f, 0.f, -1.f);

    _aspectRatio = (float)p_imgWidth / p_imgHeight;
    _fov = p_fov;

    updateViewPort();
  }

  void updateViewPort()
  {
    float x = 2.f * tan( radians( _fov * 0.5f ) );
    float y = x * _aspectRatio;

    _vU = PVector.mult(_u, y);
    _vV = PVector.mult(_v, x);
    _vC = PVector.sub(PVector.add(PVector.sub(_position, PVector.mult(_vU, 0.5f)), PVector.mult(_vV, 0.5f)), _w);
  }

  //==================================

  PVector _position;

  // Camera coordinate system
  PVector _u;
  PVector _v;
  PVector _w;

  // Viewport
  //  _vC    _vU
  //     *---------->
  //     |
  // _vV |
  //     |
  //    V
  PVector _vU;
  PVector _vV;
  PVector _vC; // Top left corner

  float _aspectRatio; // ratio width/height
  float _fov; // field of view

Rayon generateRay(float p_x, float p_y) {
    PVector dir; // déclaration du vecteur direction pour le rayon
  
    // Combinaison linéaire des vecteurs _vU et _vV avec les coordonnées normalisées (p_x, p_y)
    dir = PVector.add(PVector.mult(_vU, p_x), PVector.mult(_vV, -p_y));
    // Ajout du vecteur _vC pour positionner correctement la direction
    dir.add(_vC);
    Rayon rayon = new Rayon(_position, (PVector.sub(dir, _position)).normalize());
    return rayon;

  }
}
