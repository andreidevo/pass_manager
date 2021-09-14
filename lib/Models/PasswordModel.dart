
import 'package:hive/hive.dart';
part 'PasswordModel.g.dart';

@HiveType(typeId: 0)
class PasswordModel extends HiveObject{

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String password;

  PasswordModel(this.title, this.password);
}

@HiveType(typeId: 1)
class PassPinClass extends HiveObject{

  @HiveField(0)
  final String number;

  PassPinClass(this.number);

  bool checkPin(String newPin) => newPin != number;
}
