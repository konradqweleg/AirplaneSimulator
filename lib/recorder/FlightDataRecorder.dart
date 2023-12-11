
import 'dart:io';

class FlightDataRecorder{

  static const String _basePathForStatusFiles = "C:\\MyChat\\airplane\\data";
  static const String _engineLeftNameFile = "engineLeft";

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

}