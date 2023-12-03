class ControlColumn {
  double _horizontalRawPosition = 100.0;
  double _verticalRawPosition = 100.0;

  static const  double MAX_ANGLE_DEGREES = 90.0;
  static const  double SCALE_FACTOR_RAW_POSITION_TO_DEGREES = 0.9;
  static const  double MINUS_THRESHOLD = -0.001;

  double _scaleRawValueToDegrees(double rawPosition){
    return rawPosition * SCALE_FACTOR_RAW_POSITION_TO_DEGREES;
  }

  double getRawHorizontalControlColumnPosition(){
    return _horizontalRawPosition;
  }

  double getRawVerticalControlColumnPosition(){
    return _verticalRawPosition;
  }

  void setRawHorizontalControlColumnPosition(double newPosition){
    _horizontalRawPosition = newPosition;
  }

  void setRawVerticalControlColumnPosition(double newPosition){
    _verticalRawPosition = newPosition;
  }

  double getHorizontalAngle() {
    double scaledToAngeleRange = _scaleRawValueToDegrees(_horizontalRawPosition);

    if (scaledToAngeleRange >= MAX_ANGLE_DEGREES) {


      //In practice, this condition aims to set the upper limit of the angle value to 90 degrees if it exceeds that limit.
      // If the difference is greater than MINUS_THRESHOLD (very close to zero), it signifies that the angle value is close to the maximum value.
      // This is considered as reaching the maximum value, and thus, 0.0 is returned as a result to maintain the angle value within the allowable range.
      if((-(scaledToAngeleRange - MAX_ANGLE_DEGREES)) > MINUS_THRESHOLD ){ // related to set absolute max as <90 degrees even when we set 90
        return 0.0;
      }

      return -(scaledToAngeleRange - MAX_ANGLE_DEGREES);
    } else { //90 - angle
      return MAX_ANGLE_DEGREES - scaledToAngeleRange;
    }
  }

  double getVerticalAngle(){
    double scaledToAngeleRange = _verticalRawPosition * SCALE_FACTOR_RAW_POSITION_TO_DEGREES;
    if(scaledToAngeleRange > MAX_ANGLE_DEGREES){
      return scaledToAngeleRange - MAX_ANGLE_DEGREES;
    }else{

      //In practice, this condition aims to set the upper limit of the angle value to 90 degrees if it exceeds that limit.
      // If the difference is greater than MINUS_THRESHOLD (very close to zero), it signifies that the angle value is close to the maximum value.
      // This is considered as reaching the maximum value, and thus, 0.0 is returned as a result to maintain the angle value within the allowable range.
      if(-(MAX_ANGLE_DEGREES - scaledToAngeleRange) > MINUS_THRESHOLD){// related to set absolute max as <90 degrees even when we set 90
        return 0.0;
      }

      return -(90 - scaledToAngeleRange);
    }

  }




}
