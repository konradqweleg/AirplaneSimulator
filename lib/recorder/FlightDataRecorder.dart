
import 'dart:io';

class FlightDataRecorder{

  static const String _basePathForStatusFiles = "C:\\Users\\Konrad\\StudioProjects\\AirplaneSimulator\\data";
  static const String _engineLeftNameFile = "engineLeft";
  static const String _engineRightNameFile = "engineRight";
  static const String _brakesFileName = "brakes";
  static const String _chassisFileName = "chassis";
  static const String _controlColumnVerticalFileName = "controlColumnVertical";
  static const String _controlColumnHorizontalFileName = "controlColumnHorizontal";
  static const String _flapsFileName = "flaps";

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
    rf.writeStringSync("$textToAppend,");
    rf.closeSync();
  }

  static void saveLeftEngineStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _engineLeftNameFile,value.toString());
  }

  static void saveRightEngineStatus(double value){
    _appendTextToCSVFile(_basePathForStatusFiles, _engineRightNameFile,value.toString());
  }

  static void saveBrakesStatus(bool value){
    _appendTextToCSVFile(_basePathForStatusFiles, _brakesFileName,value.toString());
  }

  static void saveChassisStatus(bool value){
    _appendTextToCSVFile(_basePathForStatusFiles, _chassisFileName,value.toString());
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

}