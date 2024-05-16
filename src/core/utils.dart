import 'dart:io';
// TODO: Add any utility functions here

//this class takes care of all logical IO operations
abstract class Note{
  static var _file, _printer;

  /*
   *This method opens OR creates a file. If a file with the name [fileName] does not exist, it creates a new file named [fileName].
   *
   * @param fileName [String] : this variable embodies the file name and format. (EX: test.txt)
   * @param append [bool] : this variable determines weather the file's previous content is wiped or appended to.
   */
  static void open(String fileName, bool? append){
    if(append == null)
      append = true;

    var mode = {
      true : FileMode.append,
      false : FileMode.write,
    };

    _file = File(fileName);
    _printer = _file.openWrite(mode: mode[append]);

  }

  /*
  * This method simply invokes File.write() method
  *
  * @param text [String]: is the text the user wants to write.
  * */
  static void write(String text){
    try{
      _printer.write(text + "\n");
    }
    catch(e){
      throw("No File was Selected!");
    }
  }

  //This method simply invokes File.delete
  static void delete(String fileName) {
    _find(fileName);
    _file.delete();
  }

  //This method simply invokes File.existsSync
  static bool exists(String fileName){
      return File(fileName).existsSync();
  }

  //used when user desires to terminate program
  static void close(){
    _printer.flush();
    _printer.close();
  }

  //this method prevents deletion-error by checking if file exists.
  static void _find(String fileName){
    if(exists(fileName))
      _file = File(fileName);
    else
      throw("File not found!");
  }
}