import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure/Models/PasswordModel.dart';
import 'package:flutter_secure/Models/StorageAccess.dart';
import 'package:flutter_beautiful_popup/main.dart';


class PasswordsScreen extends StatefulWidget {
  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerPass = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: storageAccess.mainListStream,
          initialData: <PasswordModel>[],
          builder: (_, AsyncSnapshot<List<PasswordModel>> snap) {

            List<Widget> list = [];
            for (var object in snap.data!)
              list.add(_buildItem(object));

            return Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ListView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Passwords", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 60,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: list,
                  )
                ],
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: (){

          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  title: Text("Alert Dialog", style: TextStyle(fontWeight: FontWeight.bold),),
                  content: Container(
                    constraints: BoxConstraints(
                      maxHeight: 200
                    ),
                    child: Column(
                      children: [
                        TextField(
                          //focusNode: focusNode,
                          showCursor: true,
                          maxLines: null,
                          controller: controllerTitle,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Название",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                        TextField(
                          //focusNode: focusNode,
                          showCursor: true,
                          maxLines: null,
                          controller: controllerPass,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Пароль",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: CupertinoButton(
                              onPressed: () async {
                                  if (controllerTitle.text != "" && controllerPass.text != ""){
                                    storageAccess.createPassObject(controllerTitle.text, controllerPass.text);
                                    Navigator.of(context).pop();
                                  }

                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Center(
                                  child: Text(
                                    "Сохранить",
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
                    ),
                  ),
                );
              }
          );
            // bool barrierDismissible = false,
            // Widget close,
        },
      ),
    );
  }

  Widget _buildItem(PasswordModel passwordModel){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(passwordModel.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          SizedBox(height: 1,),
          Text(passwordModel.password, style: TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.bold)),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}
