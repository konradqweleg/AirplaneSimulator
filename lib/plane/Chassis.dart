class Chassis{

  bool _isEnable = true;

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