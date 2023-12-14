class Brakes{

  bool _isEnable = false;

  void enableBrakes(){
    _isEnable = true;
  }

  void disableBrakes(){
    _isEnable = false;
  }

  bool isBrakesEnabled(){
    return _isEnable;
  }

}