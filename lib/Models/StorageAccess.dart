
import 'dart:io';

import 'package:hive/hive.dart';
import 'PasswordModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageAccess{

  late Box<PasswordModel> listStorage;
  late Box<PassPinClass> pinCode;


  Future<bool> initStorage() async {

    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(PasswordModelAdapter());
    Hive.registerAdapter(PassPinClassAdapter());

    listStorage = await Hive.openBox<PasswordModel>("passwords");
    pinCode = await Hive.openBox<PassPinClass>("pin");


    return true;
  }
  Future<bool> savePinCode(String pin) async {

    await pinCode.add(PassPinClass(pin));

    return true;
  }
}


final storageAccess = StorageAccess();


