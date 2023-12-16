class Chassis{

  bool _isEnable = false;

  void ejectChassis(){
    _isEnable = true;
  }

  void hideChassis(){
    _isEnable = false;
  }

  bool isEjectedChassis(){
    return _isEnable;
  }

}