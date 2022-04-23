import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /// SINGLETOONE DESIGN PATTERN IMPLEMENTATION
  /// THIS IS PRIVATE CONSTRUCTOR, I USE IT BECAUSE NO ONE CAN CREATE OBJECT FROM THIS CLASS
  /// I AM USING THIS PATTERN FOR SHARING THE SAME INSTANCE IN ALL PROJECT
  /// AND DO NOT CONSUME DEVICE RESOURCES WHEN CREATE NEW INSTANCES FROM THE SAME CLASS
  DatabaseHelper._();

  static final DatabaseHelper dbHelper = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  /// CREATE DATABASE
  initializeDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String dbName = path.join(dbPath, 'articleDatabase.db');
    return await openDatabase(dbName, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $dbTableName(
      $dbColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $dbColumnTitle TEXT NOT NULL,
      $dbColumnUrl TEXT NOT NULL,
      $dbColumnImageUrl TEXT NOT NULL,
      $dbColumnPublishedAt TEXT NOT NULL,
      $dbColumnAuthor TEXT NOT NULL,
      $dbColumnSource TEXT NOT NULL)
      ''');
    });
  }

  /// INSERT IN DATABASE
  Future<void> insertArticle(Article article) async {
    var databaseClient = await database;
    await databaseClient!.insert(dbTableName, article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// READ FROM DATABASE
  Future<List<Article>> getAllSavedArticles() async {
    var databaseClient = await database;
    List<Map<String, dynamic>> jsonData = await databaseClient!.query(dbTableName);
    return jsonData.isNotEmpty
        ? jsonData
            .map(
              (item) => Article.fromLocalJson(item),
            )
            .toList()
        : [];
  }

  /// DELETE FROM DATABASE
  Future<void> deleteArticle(String publishedAt) async {
    var databaseClient = await database;
    await databaseClient!.delete(dbTableName,
        where: '$dbColumnPublishedAt = ?', whereArgs: [publishedAt]);
  }
}
