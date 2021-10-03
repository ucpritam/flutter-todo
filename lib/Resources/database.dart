import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflitecurd/models/taskModels.dart';

class DatabaseResource {
  static final DatabaseResource instance = DatabaseResource._instance();
  static Database _db;

  DatabaseResource._instance();

  String toDoTable = "todoTaskTable";
  String columnId = "id";
  String columnTitle = "title";
  String columnStatus = "status";

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "things_ToDo.db";
    final thingsTodoDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return thingsTodoDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $toDoTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnStatus INTEGER)",
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(toDoTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(toDoTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(
      toDoTable,
      task.toMap(),
      where: "$columnId = ?",
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      toDoTable,
      where: "$columnId = ? ",
      whereArgs: [id],
    );
    return result;
  }
}
