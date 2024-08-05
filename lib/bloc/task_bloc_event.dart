

import 'package:taskmanager/modals/task.dart';
//!EVENT

abstract class TaskEvent  {
  const TaskEvent();
  
  @override

  List<Object> get props => [];
}
//get event

class LoadTasks extends TaskEvent {}

//add event

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}
//delete event

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}
