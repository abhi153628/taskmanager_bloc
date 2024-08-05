import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskmanager/modals/task.dart';

class TaskRepository {
  final String baseUrl = 'https://api.nstack.in/v1/todos';

  Future<List<Task>> fetchTasks() async {
    //getting the api
    final response = await http.get(Uri.parse('$baseUrl?page=1&limit=20'));
    if (response.statusCode == 200) {
      final List<dynamic> items = jsonDecode(response.body)['items'];
      return items.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
   Future<void> addTask(Task task) async {
    //posting the data
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add task');
    }
  }
  //deleting 
    Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
  
  
