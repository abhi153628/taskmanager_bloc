import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc_bloc.dart';
import 'package:taskmanager/bloc/task_bloc_event.dart';
import 'package:taskmanager/bloc/task_bloc_state.dart';
import 'package:taskmanager/views/add_task_screen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     context.read<TaskBloc>().add(LoadTasks());
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TASK MANAGER",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          log(state.runtimeType.toString());
          //if the data is fetching
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } 
          //if the data is fetched
          else if (state is TaskLoaded) {
            //task is the list of fetched task
            final tasks = state.tasks;
            //scrolable list of task list view builder
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'delete') {
                        context.read<TaskBloc>().add(DeleteTask(task.id));
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 'delete',
                        ),
                      ];
                    },
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('Failed to load tasks!'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (result == true) {
            context.read<TaskBloc>().add(LoadTasks());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
