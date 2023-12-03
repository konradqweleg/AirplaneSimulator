class Distance{
  double _metresFromStartingPath = 0.0;

  double getMetresFromStartingRunWay(){
    return _metresFromStartingPath;
  }

  void updateDistance(double addMetres){
    _metresFromStartingPath += addMetres;
  }
}