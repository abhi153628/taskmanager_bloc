
import 'package:taskmanager/modals/task.dart';
//!STATE


abstract class TaskState {
  const TaskState();
  
  @override
  //for ascessing the list
  List<Object> get props => [];
}
//get state

class TaskLoading extends TaskState {}
//sucess state

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
//error state


class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
