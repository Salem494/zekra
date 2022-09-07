import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/model/cubit/states.dart';
import 'package:todo_app/view/screens/archive_screen.dart';
import 'package:todo_app/view/screens/done_screen.dart';
import 'package:todo_app/view/screens/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List newTasks = [];
  List doneTasks = [];
  List archiveTasks = [];

  late Database database;
  int selectedIndex = 0;
  List<Widget> screen = [TaskScreen(), DoneScreen(), ArchiveScreen()];
  List<String> titles = ["Tasks", "Done", "Archive"];
  bool bottomSheet = false;
  IconData fatIcon = Icons.edit;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    bottomSheet = isShow;
    fatIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void createdDatabase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) {
      print("Created DataBase");
      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
          .then((value) {
        print("Create Table");
      }).catchError((e) {
        print("ERORR : IS $e");
      });
    }, onOpen: (database) {
      print("Opened DataBase");
      getDataFromDatabase(database).then((value) {
        emit(AppGetDataBaseState());
      });
    }).then((value) {
      database = value;
      emit(AppCreatedDataBaseState());
    });
  }

 void insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO Tasks(title,time,date,status) VALUES("$title", "$time", "$date","new")')
          .then((value) {
        print(" $value Insert Successful");
        emit(AppInsertDataBaseState());
        getDataFromDatabase(database).then((value) {
          newTasks = value;
          emit(AppGetDataBaseState());
        });
      }).catchError((e) {
        print("Error is : $e");
      });
    });
  }

  Future getDataFromDatabase(Database database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    return await database.rawQuery('SELECT * FROM Tasks').then((value) {
      emit(AppGetDataBaseState());

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
      'UPDATE Tasks SET status = ?  WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteDatabase({
    required int id,
  }) {
    database.rawDelete(
      'DELETE FROM Tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isDark = false;

  void changeDarkMode({bool? value}) {
    if (value != null) {
      isDark = value;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      sharedHelper.setData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
