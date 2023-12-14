class ThrustReversers{

  bool _isEnable = false;

  void enableThrustReversers(){
    _isEnable = true;
  }

  void disableThrustReversers(){
    _isEnable = false;
  }

  bool isThrustReversersEnabled(){
    return _isEnable;
  }


}