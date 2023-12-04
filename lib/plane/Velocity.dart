class Velocity{
  double _velocityHorizontal =0.0;
  double _velocityVertical = 0.0;
  double _maxAccelerationOnGroundPerPointRestrictor = 0.000017057; //przyspieszenie maksymalne
  double _maxAccelerationOnFlyPerPointRestrictor = 0.000042647;
  double _speedV1 = 0.00045827;

  static const double _speedV1MetresPerSecond = 72.2;

  double _maxSpeedInMetersPerSecond = 277.77;
  double _minSpeedInFly = 72.2;


  double getSpeedV1InMetresPerSeconds(){
    return _speedV1MetresPerSecond;
  }

  double getVelocityHorizontal(){
    return _velocityHorizontal;
  }

  void setVelocityHorizontal(double velocity){
    _velocityHorizontal = velocity;
  }

  double getVelocityVertical(){
    return _velocityVertical;
  }

  void setVelocityVertical(double velocity){
    _velocityVertical = velocity;
  }

}