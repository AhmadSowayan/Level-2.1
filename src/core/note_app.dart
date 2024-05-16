import 'dart:ffi';

import 'utils.dart';
import 'dart:io';


/*this class takes care of the command-line user interface.
* @param path [String?]: is the file path
* @param choicePrompt [int?]: is responsible for Y/N operations
* @param fileSelectionFlag [bool]: a boolean variable that dictates a user's interest in selecting files.
* @param inFileOperationsFlag [bool]: a boolean variable that dictates a user's interest in manipulating a selected file.
*/

class NoteApp {
  // TODO: Complete the run function
  void run() {

    String? path;

    int? choicePrompt;
    var binaryPrompt = {
      1 : false,
      2 : true
    };

    bool inFileOperationsFlag = true,
         fileSelectionFlag = true;

    while(fileSelectionFlag){
      try{
        inFileOperationsFlag = true;


        print("\n-----------------------------------------------------------------------------------\n"
            "Please Select One of The Following Operations:\n"
            "1-Access File\n"
            "2-Delete File\n"
            "3-Exit program\n");
        choicePrompt = int.parse(stdin.readLineSync()!);
        switch(choicePrompt){


          case(1):
            print("Please insert file name and format [EX: dummyFile.txt]: ");
            path = stdin.readLineSync()!;

            if(!Note.exists(path)){
              print("File not found... A new file will be created.");
            }

            Note.open(path, true);
            break;

          case(2):
            print("Please insert file name and format [EX: dummyFile.txt]: ");
            path = stdin.readLineSync()!;
            Note.delete(path);
            continue;

          case(3):
            inFileOperationsFlag = false;
            fileSelectionFlag = false;
        }



        while (inFileOperationsFlag){
          try{

            print("\n-----------------------------------------------------------------------------------\n"
                "Please Select One of The Following Operations:\n"
                "1-Edit File\n"
                "2-Select Another File\n"
                "3-Exit Program\n");

            choicePrompt = int.parse(stdin.readLineSync()!);

            switch(choicePrompt){

              case(1):
                print("Do you wish to erase previous notes from file?  [PRESS 1]: ");
                Note.open(path!, binaryPrompt[int.parse(stdin.readLineSync()!)]);
                print("-->");
                Note.write(stdin.readLineSync()!);
                break;
              case(2):
                inFileOperationsFlag = false;
                break;
              case(3):
                inFileOperationsFlag = false;
                fileSelectionFlag = false;
                Note.close();
                break;

            }

          }
          catch(e){
            print(e.toString() + "\n-----------------------------------------------------------------------------------");
          }

        }
      }
      catch(e){
        e.toString();
      }
    }





  }
}
