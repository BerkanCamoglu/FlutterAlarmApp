// ignore_for_file: prefer_final_fields, unnecessary_null_comparison
import 'package:flutteralarmapp/core/init/database/database_provider.dart';
import 'package:flutteralarmapp/product/models/alarm_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmDatabaseProvider extends DatabaseProvider<AlarmModel> {
  static final AlarmDatabaseProvider instance = AlarmDatabaseProvider._init();

  static Database? _database;

  AlarmDatabaseProvider._init();

  String _alarmDatabaseName = "alarmDatabase.db";
  String _alarmTableName = "alarm";
  int _version = 1;
  String _columnId = "id";
  String _columnDatetime = "dateTime";
  String _columnTitle = "title";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_alarmDatabaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final response =
        await openDatabase(path, version: _version, onCreate: _createDB);
    return response;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_alarmTableName (
      $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $_columnDatetime DATETIME,
      $_columnTitle CHAR(45)
    )
    ''',
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  @override
  Future<bool?> add(AlarmModel model) async {
    final db = await instance.database;
    final alarmMap = await db.insert(
      _alarmTableName,
      model.toJson(),
    );

    return alarmMap != null;
  }

  @override
  Future<bool?> delete(int id) async {
    final db = await instance.database;
    final alarmMap = await db.delete(
      _alarmTableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    return alarmMap != null;
  }

  @override
  Future<AlarmModel?> get(int id) async {
    final db = await instance.database;
    final alarmMap = await db.query(
      _alarmTableName,
      where: '$_columnId = ?',
      columns: [_columnId],
      whereArgs: [id],
    );

    if (alarmMap.isNotEmpty) {
      return AlarmModel.fromJson(alarmMap.first);
    }
    return null;
  }

  @override
  Future<List<AlarmModel>?> getAll() async {
    final db = await instance.database;

    List<Map<String, dynamic>> alarmMap = await db.query(_alarmTableName);
    if (alarmMap.isNotEmpty) {
      return alarmMap.map((e) => AlarmModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<bool?> update(int id, AlarmModel model) async {
    final db = await instance.database;

    final alarmMap = await db.update(
      _alarmTableName,
      model.toJson(),
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    return alarmMap != null;
  }
}
