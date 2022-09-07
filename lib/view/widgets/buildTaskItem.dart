import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
   onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: model['id']);
   },
  child:   ListTile(
        leading: CircleAvatar(
          child: Text(
            model['time'],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          radius: 40.0,
          backgroundColor: Colors.red,
        ),
        title: Text(
          model['title'],
          style:  Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(model['date'],style:  Theme.of(context).textTheme.bodyText2,),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'archive', id: model['id']);
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
);
