import 'package:rest_api_app/Models/Todo.dart';
import 'package:rest_api_app/Repository/Repository.dart';

class TodoController {
  final Repository repository;

  TodoController(this.repository);

  Future<List<Todo>> fetchTodoList() async {
    return repository.getTodoList();
  }

  Future<String> UpdatePatchCompleted(Todo todo) async {
    return repository.patchCompleted(todo);
  }

  Future<String> updatePutCompleted(Todo todo) async {
    return repository.putCompleted(todo);
  }

  Future<String> deletetodo(Todo todo) async {
    return repository.deletedTodo(todo);
  }

  Future<String> postTodo(Todo todo) async {
    return repository.postTodo(todo);
  }
}
