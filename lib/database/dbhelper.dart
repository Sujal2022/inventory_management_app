import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper
{

  //database name and version
  static final _databaseName = "inventory.db";
  static final _databaseVersion = 1;

  //table names
  final catid = "id";
  final catname = "c_name";
  final tablename = "logintable";

  static final columnId1 = '_id';
  static final columnName = 'name';
  static final columnEmail = 'email';
  static final columnPhone = 'phone';
  static final columnPassword = 'password';
  static final columnCPassword = 'cpassword';

  //final catid1 = "id1";
  final tablename1 = "addproduct";

  static final ProductId = 'id1';
  static final ProductName = 'pname';
  static final ProductCategory = 'pcategory';
  static final ProductPrice = 'pprice';
  static final ProductNumber = 'pnumber';

  DbHelper._privateConstructor();

  static Database? _database;

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase()async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase
      (
        path, version: _databaseVersion, onCreate: _onCreate);

  }

  FutureOr<void> _onCreate(Database db, int version) async
  {

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename (
            $columnId1 INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL, 
            $columnEmail TEXT NOT NULL, 
            $columnPhone TEXT NOT NULL, 
            $columnPassword TEXT NOT NULL,
            $columnCPassword TEXT NOT NULL   
          )
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename1 (
            $ProductId INTEGER PRIMARY KEY,
            $ProductName TEXT NOT NULL, 
            $ProductCategory TEXT NOT NULL, 
            $ProductPrice TEXT NOT NULL, 
            $ProductNumber TEXT NOT NULL     
          )
          ''');
  }

  //insert contact //it for logintable
  Future<int?> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tablename, row);
  }
  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result =
    await db.query('logintable', where: "email = ?", whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result =
    await db!.query(tablename, where: "$columnEmail = ?", whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int?> insertproduct(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tablename1, row);
  }

 /* Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tablename1);
  }*/
  Future<List<Map<String, dynamic>>> queryAllRowsaddproducts() async {
    Database db = await instance.database;
    return await db.query(tablename1);//select * from contact
  }

  /*Future<int> delete(int id) async
  {
    Database db = await instance.database;
    return await db.delete(tablename1, where: '$ProductId = ?', whereArgs: [id]);
  }*/

  Future<int> deleteProduct(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tablename1, // Table name is 'addproduct'
      where: '$ProductId = ?', // Column name is 'id1'
      whereArgs: [id],
    );
  }

  Future<int> updateProduct(Map<String, dynamic> row) async {
    final db = await database;
    int id = row['id1']; // Use the id to update the specific product
    return await db.update(
      tablename1, // Table name
      row,
      where: '$ProductId = ?',
      whereArgs: [id],
    );
  }

 /* Future<int> updateProduct(int id, Map<String, dynamic> product) async {
    final db = await database; // Assuming you have a method to get the database instance
    return await db.update(
      tablename1, // Replace 'products' with your actual table name
      product,
      where: '$ProductId = ?', // Assuming 'id1' is the unique identifier for your products
      whereArgs: [id],
    );
  }*/


}