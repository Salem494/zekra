import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBasModel {
  static late Database _db;

  Future<Database?> get db  async{
    if(_db == null){
      _db = intialDB();
    }else{
      return _db;
    }
  }

  intialDB() async {
    String databathPath = await getDatabasesPath();
    String path = join(databathPath, "todo.db");
    Database database =
        await openDatabase(path, version: 1, onCreate: createdDatabase());
    print("sallllllllem");
    return database;
  }

     createdDatabase() async {
    await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      print("create DB");
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)")
          .then((value) {
        print("Table Created !!!");
      }).catchError((error) {
        print("Error when fetching Data ${error.toString()}");
      });
    }, onOpen: (database) {
      print("data Open");
    });

  }

   insertDatabase(){

      _db.transaction((txn) {
     return txn.rawInsert(
          'INSERT INTO tasks(title, date , time , status) VALUES ("salem","010","50","new")');
    }).then((value) {
      print("successful insert ");
    }).catchError((error) {
      print("error table :${error.toString()}");
    });
      return null;
  }
}
