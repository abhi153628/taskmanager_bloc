import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:taskmanager/bloc/task_bloc_event.dart';
import 'package:taskmanager/bloc/task_bloc_state.dart';
import 'package:taskmanager/modals/repository.dart';
//!BLOC

//event as input , emit state
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskLoading()) {
    //handling the event and emiting according to that
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.fetchTasks(); 
        emit(TaskLoaded(tasks));
      } catch (e) { 
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await taskRepository.addTask(event.task);
        final tasks = await taskRepository.fetchTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskRepository.deleteTask(event.id);
        final tasks = await taskRepository.fetchTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
