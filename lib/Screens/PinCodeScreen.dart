

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure/Models/StorageAccess.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'PasswordsScreen.dart';

enum StartModeEnum {INIT, OPEN}

class PinCodeScreen extends StatefulWidget {

  StartModeEnum mode;

  PinCodeScreen(this.mode);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {

  String setPinCode = "";

  @override
  Widget build(BuildContext context) {

    switch (widget.mode){
      case StartModeEnum.INIT:
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    pastedTextStyle: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    animationType: AnimationType.fade,
                    animationDuration: Duration(milliseconds: 300),
                    pinTheme: PinTheme(
                      selectedColor: Colors.red,
                      inactiveColor: Colors.black,
                      activeColor: Colors.deepPurpleAccent
                    ),
                    //errorAnimationController: errorController, // Pass it here
                    onChanged: (value) {
                      setState(() {
                        setPinCode = value;
                      });
                    },
                    appContext: context,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: CupertinoButton(
                    onPressed: () async {
                      if (setPinCode.length == 6){
                        // save and open menu with passwords

                        await storageAccess.savePinCode(setPinCode);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => PasswordsScreen())
                        );
                      }
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(
                        child: Text(
                          "Сохранить Pin",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        );
      case StartModeEnum.OPEN:
        return Scaffold();
    }
  }
}
