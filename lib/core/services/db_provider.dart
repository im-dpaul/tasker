import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasker/features/tasks/models/tasks_model.dart';

class DBProvider {
  Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tasker.db');

    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE tasks 
      (id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      status TEXT NOT NULL,
      createdAt TEXT,
      updatedAt TEXT)''',
    );
  }

  Future<TasksModel> insert(TasksModel taskModel) async {
    Database? dbClient = await database;

    await dbClient!.insert('tasks', taskModel.toMap());
    return taskModel;
  }

  Future<List<TasksModel>> getTasks() async {
    Database? dbClient = await database;
    final data = await dbClient!.query('tasks');
    return data.map((e) => TasksModel.fromMap(e)).toList();
  }

  Future<void> delete(int id) async {
    Database? dbClient = await database;

    await dbClient!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMany(List<int> idList) async {
    Database? dbClient = await database;

    await dbClient!.delete(
      'tasks',
      where: 'id IN (${List.filled(idList.length, '?').join(',')})',
      whereArgs: idList,
    );
  }

  Future<void> update(TasksModel taskModel) async {
    Database? dbClient = await database;

    await dbClient!.update(
      'tasks',
      taskModel.toMap(),
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );
  }
}
