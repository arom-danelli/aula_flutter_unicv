import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  late Database _database;

  Future<void> inicializarDatabase() async {
    _database = await openDatabase(
    join(await getDatabasesPath(),'tarefas_database.db'),
    onCreate: (db,version){
      return db.execute('CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT, concluida INTEGER)');
    },
    version: 1,
    );
  }

}