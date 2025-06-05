import '../models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;

  static const tableName = "todo";

  static const columnId = 'id';
  static const columnJudul = 'judul';
  static const columnDeskripsi = 'deskripsi';
  static const columnIsDone = 'isDone';

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnJudul TEXT NOT NULL,
            $columnDeskripsi TEXT NOT NULL,
            $columnIsDone INTEGER NOT NULL
          )
      ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> queryAllRows() async {
    final db = await database;

    List<Map<String, dynamic>> todos =
        await db.query(tableName, orderBy: "$columnId DESC");
    return List.generate(
        todos.length,
        (index) => Todo(
              id: todos[index]['id'],
              judul: todos[index]['judul'],
              deskripsi: todos[index]['deskripsi'],
              isDone: todos[index]['isDone'] == 1 ? true : false,
            ));
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }

  Future<void> isCheckedTodo(int id, bool value) async {
    final db = await database;
    Map<String, dynamic> newTodo = {columnIsDone: value};
    await db.update(
      tableName,
      newTodo,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }
}
