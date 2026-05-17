import 'package:mona/services/db/app_database.dart';
import 'package:sqflite/sqflite.dart';

class Repository<T> {
  final Future<Database> _dbFuture;
  final String tableName;
  final Map<String, Object?> Function(T) toMap;
  final T Function(Map<String, Object?>) fromMap;

  Repository({
    Database? db,
    required this.tableName,
    required this.toMap,
    required this.fromMap,
  }) : _dbFuture =
            db != null ? Future.value(db) : AppDatabase.getInstance().database;

  Future<int> insert(T element) async {
    final db = await _dbFuture;
    final map = toMap(element);
    return await db.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAll({bool includeDeleted = false}) async {
    final db = await _dbFuture;
    final result = await db.query(
      tableName,
      where: includeDeleted ? null : 'isDeleted = 0',
    );
    return result.map(fromMap).toList();
  }

  Future<void> update(T element, dynamic id) async {
    final db = await _dbFuture;
    final map = Map<String, Object?>.from(toMap(element));
    map['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    await db.update(
      tableName,
      map,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(dynamic id) async {
    final db = await _dbFuture;
    await db.update(
      tableName,
      {
        'isDeleted': 1,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<T>> getChangesSince(int timestamp) async {
    final db = await _dbFuture;
    final result = await db.query(
      tableName,
      where: 'updatedAt > ?',
      whereArgs: [timestamp],
    );
    return result.map(fromMap).toList();
  }
}
