import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc_bloc.dart';
import 'package:taskmanager/modals/repository.dart';
import 'package:taskmanager/views/home_screen.dart';

void main() {
  runApp(MyApp(taskRepository: TaskRepository()));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;
  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(taskRepository: taskRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}
