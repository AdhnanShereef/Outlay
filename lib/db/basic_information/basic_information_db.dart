import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlay/db/basic_information/basic_information_model.dart';
import 'package:outlay/main.dart';
import 'package:outlay/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

const basicInformtionDBName = 'basic-information-db';
String? name;

abstract class BasicInformationDBFunctions {
  Future<void> getStared(BasicInformationModel obj);
  Future<void> getBasicInformations();
  // void refreshName();
}

class BasicInformationDB implements BasicInformationDBFunctions {
  BasicInformationDB._internal();
  static BasicInformationDB instance = BasicInformationDB._internal();
  factory BasicInformationDB() {
    return instance;
  }
  @override
  Future<void> getStared(BasicInformationModel obj) async {
    final _db =
        await Hive.openBox<BasicInformationModel>(basicInformtionDBName);
    await _db.put(obj.id, obj);
    final _sharedPreference = await SharedPreferences.getInstance();
    await _sharedPreference.setBool(user, true);
    userName = _sharedPreference.getString(username)!;
  }

  @override
  Future<String> getBasicInformations() async {
    final _db =
        await Hive.openBox<BasicInformationModel>(basicInformtionDBName);
    final String _name = _db.values.toList()[0].name;
    final _sharedPreference = await SharedPreferences.getInstance();
    await _sharedPreference.setString(username, _name);
    final _user = _sharedPreference.getBool(user);
    if (_user != null) {
      userName = _sharedPreference.getString(username)!;
    }

    return _name;
  }

  // @override
  // void refreshName() {}
}