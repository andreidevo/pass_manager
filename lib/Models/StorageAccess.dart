
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'PasswordModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageAccess{

  late Box<PasswordModel> listStorage;
  late Box<PassPinClass> pinCode;

  // ignore: close_sinks
  BehaviorSubject<List<PasswordModel>> _mainListStream = BehaviorSubject<List<PasswordModel>>();
  BehaviorSubject<List<PasswordModel>> get mainListStream => _mainListStream;
  List<PasswordModel> mainList = [];


  Future<bool> initStorage() async {

    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(PasswordModelAdapter());
    Hive.registerAdapter(PassPinClassAdapter());

    listStorage = await Hive.openBox<PasswordModel>("passwords");
    pinCode = await Hive.openBox<PassPinClass>("pin");

    if (listStorage.values.toList().isNotEmpty){
      mainList = listStorage.values.toList();
      _mainListStream.sink.add(mainList);
    }

    return true;
  }
  Future<bool> savePinCode(String pin) async {

    await pinCode.add(PassPinClass(pin));

    return true;
  }

  Future<bool> checkPinCode(String pin) async {

    if (pinCode.values.isNotEmpty){

      if (pinCode.values.toList()[0].number == pin)
        return true;
      else
        return false;
    }
    else
      return false;

  }

  Future<bool> createPassObject(String title, String pass) async {
    print(listStorage.values.toList());
    await listStorage.add(PasswordModel(title, pass));
    mainList = listStorage.values.toList();
    print(listStorage.values.toList());
    _mainListStream.sink.add(mainList);
    return true;
  }
}


final storageAccess = StorageAccess();


