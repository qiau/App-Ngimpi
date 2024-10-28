import 'package:ngimpi/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class NoteDatabase{
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null){
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Note.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async{
    await db.execute(
      "CREATE TABLE mynote(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, desc TEXT NOT NULL, date TEXT NOT NULL)"
    );
  }

  Future<NoteModel> insert(NoteModel noteModel) async{
    var dbClient = await db;
    await dbClient?.insert('mynote', noteModel.toMap());
    return noteModel;
  }

  Future<List<NoteModel>> getDataList() async{
    await db;
    final List<Map<String, Object?>> QueryResult = await _db!.rawQuery('SELECT * FROM mynote');
    return QueryResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('mynote', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(NoteModel noteModel) async{
    var dbClient = await db;
    return await dbClient!.update('mynote', noteModel.toMap(), where: 'id = ?', whereArgs: [noteModel.id]);
  }

  Future<NoteModel> searchById(int id) async{
    await db;
    final List<Map<String, Object?>> QueryResult = await _db!.rawQuery('SELECT * FROM mynote WHERE id = $id');
    return NoteModel.fromMap(QueryResult.first);
  }
}