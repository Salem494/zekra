import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'buildTaskItem.dart';


Widget buildTasks({
  required List tasks
}){
  return ConditionalBuilder(
   condition: tasks.length > 0 ,
    builder: (context)=>ListView.builder(
        itemBuilder: (context,i){
          return buildTaskItem(tasks[i],context);
        },
        itemCount: tasks.length
    ) ,
    fallback: (context)=>Center(
      child: Column(
        children: const [
          Text("NO Tasks Here")
        ],
      ),
    ),
  );
}
