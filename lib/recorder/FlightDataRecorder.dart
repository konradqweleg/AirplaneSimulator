
import 'dart:io';

class FlightDataRecorder{

  static const String _basePathForStatusFiles = "C:\\MyChat\\airplane\\data";
  static const String _engineLeftNameFile = "engineLeft";
  static const String _engineRightNameFile = "engineRight";
  static const String _brakesFileName = "brakes";
  static const String _chassisFileName = "chassis";
  static const String _controlColumnVerticalFileName = "controlColumnVertical";
  static const String _controlColumnHorizontalFileName = "controlColumnHorizontal";
  static const String _flapsFileName = "flaps";
  static const String _heightFileName = "height";
  static const String _inclinationPilotVerticalFileName = "inclinationPilotVertical";
  static const String _inclinationPilotHorizontalFileName = "inclinationPilotHorizontal";
  static const String _inclinationSecondPilotVerticalFileName = "inclinationSecondPilotVertical";
  static const String _inclinationSecondPilotHorizontalFileName = "inclinationSecondPilotHorizontal";
  static const String _inclinationReferenceVerticalFileName = "inclinationReferenceVertical";
  static const String _inclinationReferenceHorizontalFileName = "inclinationReferenceHorizontal";
  static const String _restrictorLeftFileName = "restrictorLeft";
  static const String _restrictorRightFileName = "restrictorRight";
  static const String _fuelFileName = "fuel";
  static const String _thrustReverserFileName = "thrustReverser";
  static const String _velocityVerticalFileName = "verticalVelocity";
  static const String _velocityHorizontalFileName = "horizontalVelocity";
  static const String _warningIsBadClapPositionFileName = "warningIsBadClapPosition";
  static const String _warningIsLowLevelFuelFileName = "warningIsLowLevelFuel";
  static const String _warningIsLowHeightFileName = "warningIsLowHeight";
  static const String _warningIsCloseStallFileName = "warningIsCloseStall";
  static const String _warningIsBrakeNoExpectedEnableFileName = "warningIsBrakeNoExpectedEnable";
  static const String _warningIsThrustReverserNoExpectedEnableFileName = "warningIsThrustReverserNoExpectedEnable";
  static const String _warningIsUnnecessarilyExtendedChassisFileName = "warningIsUnnecessarilyExtendedChassis";
  static const String _warningIsSpeedAboveThresholdFileName = "warningIsSpeedAboveThreshold";
  static const String _warningIsDifferentIndicatorsFileName = "warningIsDifferentIndicators";
  static const String _warningLeftEngineFailureFileName = "warningLeftEngineFailure";
  static const String _warningRightEngineFailureFileName = "warningRightEngineFailure";

  static const String _actualTimeFileName = "actualTime";


  static void deleteAllDatas(){
    _deleteFilesInDirectory(_basePathForStatusFiles);
  }

  static void _deleteFilesInDirectory(String directoryPath) {
    Directory directory = Directory(directoryPath);
    List<FileSystemEntity> fileList = directory.listSync();
    for (var file in fileList) {
      if (file is File) {
        file.deleteSync();
      }
    }
  }


  static void _appendTextToCSVFile(String filePath, String nameFile, String textToAppend) {
    File file = File("$filePath\\$nameFile");
    RandomAccessFile rf = file.openSync(mode: FileMode.append);
    rf.writeStringSync("$textToAppend,\n");
    rf.closeSync();
  }

  static void saveLeftEngineStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _engineLeftNameFile,value.toString());
  }

  static void saveRightEngineStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _engineRightNameFile,value.toString());
  }

  static void saveBrakesStatus(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _brakesFileName,valuesAsInt.toString());
  }

  static void saveChassisStatus(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _chassisFileName,valuesAsInt.toString());
  }

  static void saveControlColumnVerticalStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _controlColumnVerticalFileName,value.toString());
  }

  static void saveControlColumnHorizontalStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _controlColumnHorizontalFileName,value.toString());
  }

  static void saveFlapsStatus(int value){
    _appendTextToCSVFile(_basePathForStatusFiles, _flapsFileName,value.toString());
  }

  static void saveHeightStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _heightFileName,value.toString());
  }

  static void saveInclinationVerticalPilot(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationPilotVerticalFileName,value.toString());
  }

  static void saveInclinationHorizontalPilot(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationPilotHorizontalFileName,value.toString());
  }


  static void saveInclinationVerticalSecondPilot(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationSecondPilotVerticalFileName,value.toString());
  }

  static void saveInclinationHorizontalSecondPilot(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationSecondPilotHorizontalFileName,value.toString());
  }

  static void saveInclinationVerticalReference(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationReferenceVerticalFileName,value.toString());
  }

  static void saveInclinationHorizontalReference(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _inclinationReferenceHorizontalFileName,value.toString());
  }

  static void saveRestrictorLeft(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _restrictorLeftFileName,value.toString());
  }

  static void saveRestrictorRight(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _restrictorRightFileName,value.toString());
  }

  static void saveFuel(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _fuelFileName,value.toString());
  }

  static void saveThrustReverser(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _thrustReverserFileName,valuesAsInt.toString());
  }

  static void saveVelocityHorizontal(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _velocityHorizontalFileName,value.toString());
  }

  static void saveVelocityVertical(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _velocityVerticalFileName,value.toString());
  }


  static void saveWarningIsBadClapPosition(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsBadClapPositionFileName,valuesAsInt.toString());
  }

  static void saveWarningIsLowLevelFuel(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsLowLevelFuelFileName,valuesAsInt.toString());
  }

  static void saveWarningIsLowHeight(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsLowHeightFileName,valuesAsInt.toString());
  }

  static void saveWarningIsCloseStall(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsCloseStallFileName,valuesAsInt.toString());
  }

  static void saveWarningIsBrakeNoExpectedEnable(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsBrakeNoExpectedEnableFileName,valuesAsInt.toString());
  }

  static void saveWarningIsThrustReverserNoExpectedEnable(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsThrustReverserNoExpectedEnableFileName,valuesAsInt.toString());
  }

  static void saveWarningIsUnnecessarilyExtendedChassis(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsUnnecessarilyExtendedChassisFileName,valuesAsInt.toString());
  }

  static void saveWarningIsSpeedAboveThreshold(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsSpeedAboveThresholdFileName,valuesAsInt.toString());
  }

  static void saveWarningIsDifferentIndicators(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningIsDifferentIndicatorsFileName,valuesAsInt.toString());
  }

  static void saveWarningLeftEngineFailure(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningLeftEngineFailureFileName,valuesAsInt.toString());
  }

  static void saveWarningRightEngineFailure(bool value){
    int valuesAsInt = value ? 1 : 0;
    _appendTextToCSVFile(_basePathForStatusFiles, _warningRightEngineFailureFileName,valuesAsInt.toString());
  }


 static int _timeSeconds = 0;
  static void saveActualTime(){
    _timeSeconds +=1;
    int value = _timeSeconds;
    _appendTextToCSVFile(_basePathForStatusFiles, _actualTimeFileName,value.toString());
  }



}