import 'package:flutter/cupertino.dart';
import 'package:mydj/data/jurnal.dart';
import 'package:mydj/data/login_info.dart';
import 'package:mydj/data/database_helper.dart';

class DataProvider extends ChangeNotifier {
  List<Jurnal> _jurnalTersimpan = [];

  Future<void> muatJurnal() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('jurnal', orderBy: 'id DESC');
    _jurnalTersimpan = rows.map((row) => Jurnal.fromMap(row)).toList();
    notifyListeners();
  }

  Future<void> tambahJurnal(Jurnal jurnal) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('jurnal', jurnal.toMap());
    await muatJurnal();
  }

  Future<void> hapusJurnal(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('jurnal', where: 'id = ?', whereArgs: [id]);
    await muatJurnal();
  }

  List<Jurnal> get jurnalTersimpan{
    return List.unmodifiable(_jurnalTersimpan);
  }

  Future<bool> isLoggedIn() async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    return loginInfo.isLoggedIn;
  }

  Future<void> saveLoginInfo(String username, String password) async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    loginInfo.username = username;
    loginInfo.password = password;
    loginInfo.isLoggedIn = true;
    await loginInfo.saveToSharedPreferences();
  }
}