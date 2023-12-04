class Warning{
  static bool _isBadClapPosition = false;
  static bool _isLowLevelFuel = false;
  static bool _isLowHeight = false;
  static bool _isCloseStall = false;

  static void setBadClapError(){
    _isBadClapPosition = true;
  }
  static void clearErrorBadClapPosition(){
    _isBadClapPosition = false;
  }

  static bool isBadClapPosition(){
    return _isBadClapPosition;
  }

  static void setLowLevelFuelError(){
    _isLowLevelFuel = true;
  }
  static void clearErrorLowLevelFuel(){
    _isLowLevelFuel = false;
  }

  static bool isLowLevelFuel(){
    return _isLowLevelFuel;
  }

  static void setLowHeightError(){
    _isLowHeight = true;
  }
  static void clearLowHeightError(){
    _isLowHeight = false;
  }

  static bool isLowHeight(){
    return _isLowHeight;
  }

  static void setCloseStallError(){
    _isCloseStall = true;
  }
  static void clearCloseStallError(){
    _isCloseStall = false;
  }

  static bool isCloseStall(){
    return _isCloseStall;
  }


}