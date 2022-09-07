import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/model/cubit/cubit.dart';
import 'package:todo_app/model/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/view/widgets/textFormFeildCustom.dart';

class HomeScreen extends StatelessWidget {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  final titleControl = TextEditingController();
  final timeControl = TextEditingController();
  final TextEditingController dateControl = TextEditingController();
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {}
//      setState(() {
//        currentDate = pickedDate;
//      });
  }

  bool changeIcon = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createdDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {},
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.selectedIndex]),
              actions: [
                IconButton(
                  onPressed: () {
                    print("start");
                    AppCubit.get(context).changeDarkMode();
                    print("end");
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                )
              ],
            ),
            body: cubit.screen[cubit.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archive',
                  ),
                ],
                currentIndex: cubit.selectedIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.bottomSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertDatabase(
                        title: titleControl.text,
                        time: timeControl.text,
                        date: dateControl.text);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Padding(
                            padding:
                                const EdgeInsets.only(right: 3.0, left: 3.0),
                            child: Container(
                              color: Colors.black,
                              height: 250,
                              width: double.infinity,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: titleControl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              "Title", Icons.title),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Error";
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: timeControl,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              "Time", Icons.timer_sharp),
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeControl.text =
                                              value!.format(context);
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Error";
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: dateControl,
                                      decoration: InputDecorations
                                          .buildInputDecoration_1(
                                              "Date", Icons.date_range),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Error";
                                        }
                                      },
                                      onTap: () {
                                        _selectDate(context).then((value) {
                                          dateControl.text = DateFormat.yMMMd()
                                              .format(currentDate);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fatIcon),
              elevation: 10.0,
            ),
          );
        },
      ),
    );
  }
}
