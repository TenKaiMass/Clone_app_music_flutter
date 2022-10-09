// ignore: file_names
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'data_struct.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  MyDataBase._privateConstructor();

  static final MyDataBase instance = MyDataBase._privateConstructor();
  static Database? _database;

  Future<Database?> get database async => _database ??= await initDB();

  initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    Directory currentDir = await getTemporaryDirectory();
    var toto =
        "/Users/mass/Documents/Cours/H3/M2/Projet_Docker_du_11-10/Docker_archi/my_app/databases/";
    var dbDir = await getDatabasesPath();
    var dbPath = join(toto, 'auto_gen_bank.db');

    var exist = await databaseExists(dbPath);
    if (!exist) {
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load("databases/auto_gen_bank.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPath).writeAsBytes(bytes, flush: true);
    } else {}
    return await openDatabase(dbPath);
  }

  void insertMyData(MyData musicBank) async {
    final Database? db = await database;
    await db?.insert(
      'music_bank',
      musicBank.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateMyData(MyData musicBank) async {
    final Database? db = await database;
    await db?.update("music_bank", musicBank.toMap(),
        where: "id = ?", whereArgs: [musicBank.id]);
  }

  void deleteMyData(int id) async {
    final Database? db = await database;
    db?.delete("music_bank", where: "id = ?", whereArgs: [id]);
  }

  Future<List<MyData>> musicBanks() async {
    Database? db = await instance.database;
    var maps = await db?.query('music_bank');
    List<MyData> res =
        maps!.isNotEmpty ? maps.map((c) => MyData.fromMap(c)).toList() : [];
    return res;
  }
}
