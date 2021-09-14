import 'package:flutter/material.dart';
import 'package:flutter_secure/Models/StorageAccess.dart';
import 'package:flutter_secure/Screens/PasswordsScreen.dart';
import 'package:flutter_secure/Screens/PinCodeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await storageAccess.initStorage();
  StartModeEnum mode;
  if (storageAccess.pinCode.values.isEmpty)
    mode = StartModeEnum.INIT;
  else
    mode = StartModeEnum.OPEN;

  runApp(MyApp(mode));
}

class MyApp extends StatelessWidget {

  StartModeEnum mode;
  MyApp(this.mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passwords',
      theme: ThemeData(
        primaryColor: Colors.black,

      ),
      home: PinCodeScreen(mode)
    );
  }
}

