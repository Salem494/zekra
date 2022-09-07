import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app/model/cubit/cubit.dart';
import 'package:todo_app/model/cubit/states.dart';
import 'package:todo_app/view/widgets/buildTaskItem.dart';
import 'package:todo_app/view/widgets/loading_tasks.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          var tasks = AppCubit.get(context).newTasks;
          return  buildTasks(
            tasks: tasks,
          );
        }, listener: (context,state){});
  }
}
