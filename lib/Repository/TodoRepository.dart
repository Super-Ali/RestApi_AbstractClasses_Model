import 'dart:convert';

import 'package:rest_api_app/Models/Todo.dart';
import 'package:rest_api_app/Repository/Repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String dataUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<String> deletedTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = false;
    await http.delete(url).then((value) {
      print(value.body);

      return result = true;
    });
    return result.toString();
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    print("Status Code : ${response.statusCode}");
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resdata = '';
    await http.patch(url,
        body: {"completed": (todo.completed).toString()},
        headers: {'Authorization': 'your_token'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resdata = result['completed'].toString();
    });
    return resdata;
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resdata = '';
    await http.put(url,
        body: {"completed": (todo.completed).toString()},
        headers: {'Authorization': 'your_token'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resdata = result['completed'].toString();
    });
    return resdata;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    print(todo.toJson());
    var url = Uri.parse('$dataUrl/todos/');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    print(response.statusCode);
    print(response.body);
    return 'true';
  }
}
