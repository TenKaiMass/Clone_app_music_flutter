import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'data_struct.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  MyDataBase._();

  static final MyDataBase instance = MyDataBase._();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "ma_bank.db");
    print(dbPath);
    exit(0);
    // Delete any existing database:
    //await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/demo.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    return await openDatabase(dbPath);
    // var database = await openDatabase(
    //     join(await getDatabasesPath(), 'ma_bank.db'),
    //     version: 1,
    //     onCreate: initDB());
    // return database;
  }

  void insertMyData(MyData musicBank) async {
    final Database db = await database;
    await db.insert(
      'music_bank',
      musicBank.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateMyData(MyData musicBank) async {
    final Database db = await database;
    await db.update("music_bank", musicBank.toMap(),
        where: "id = ?", whereArgs: [musicBank.id]);
  }

  void deleteMyData(int id) async {
    final Database db = await database;
    db.delete("music_bank", where: "id = ?", whereArgs: [id]);
  }

  Future<List<MyData>> musicBanks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('music_bank');
    List<MyData> musicBanks = List.generate(maps.length, (i) {
      return MyData.fromMap(maps[i]);
    });

    // if (music_banks.isEmpty) {
    //   for (MyData music_bank in defaultMyDatas) {
    //     insertMyData(music_bank);
    //   }
    //   music_banks = defaultMyDatas;
    // }

    return musicBanks;
  }
}
