class Restrictor{
  double _leftRestrictorPosition = 0.0;
  double _bothRestrictorSamePosition = 0.0; //The throttle position of both the left and right engines is the same. This helps in the widget's code to simulate changes in both simultaneously
  double _rightRestrictorPosition = 0.0;
  static const double _MAX_POSITION_RESTRICTOR = 121000.0;


  void setBothRestrictorPosition(double newPosition){
    _bothRestrictorSamePosition = newPosition;
  }

  double getBothRestrictorPosition(){
    return _bothRestrictorSamePosition;
  }

  double getMaxPositionRestrictor(){
    return _MAX_POSITION_RESTRICTOR;
  }

  double getSumPositionRestrictor(){
    return _leftRestrictorPosition + _rightRestrictorPosition;
  }

  double getLeftPositionRestrictor(){
    return _leftRestrictorPosition;
  }

  double getRightPositionRestrictor(){
    return _rightRestrictorPosition;
  }

  void setLeftPositionRestrictor(double newPosition){
    _leftRestrictorPosition = newPosition;
  }

  void setRightPositionRestrictor(double newPosition){
    _rightRestrictorPosition = newPosition;
  }
}