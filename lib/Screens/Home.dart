import 'package:flutter/material.dart';
import 'package:rest_api_app/Constants/Styles.dart';
import 'package:rest_api_app/Controllers/TodoController.dart';
import 'package:rest_api_app/Models/Todo.dart';
import 'package:rest_api_app/Repository/Repository.dart';
import 'package:rest_api_app/Repository/TodoRepository.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());
    todoController.fetchTodoList();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Todo todo = Todo(id: 3, title: 'Sample Post', completed: false);
            todoController.postTodo(todo);
          },
          child: Icon(
            Icons.add,
            color: brightgreen,
          ),
          backgroundColor: darkgreen,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: black,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Posts',
              style: greenColoredBold,
            ),
          ),
          backgroundColor: green,
        ),
        body: FutureBuilder<List<Todo>>(
            future: todoController.fetchTodoList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error"),
                );
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    var todo = snapshot.data?[index];
                    return Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${todo!.id.toString()}",
                              style: whiteColoredBold,
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                "${todo.title}",
                                style: whiteColoredBold,
                              )),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    FloatingActionButton.small(
                                      onPressed: () {
                                        todoController.UpdatePatchCompleted(
                                                todo)
                                            .then((value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(value))));
                                      },
                                      child: const Text(
                                        "Patch",
                                        style: greenColored,
                                      ),
                                      backgroundColor: green,
                                    ),
                                    FloatingActionButton.small(
                                      onPressed: () {
                                        todoController.updatePutCompleted(todo);
                                      },
                                      child: const Text(
                                        "put",
                                        style: greenColored,
                                      ),
                                      backgroundColor: green,
                                    ),
                                    FloatingActionButton.small(
                                      onPressed: () {
                                        todoController.deletetodo(todo).then(
                                            (value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(value))));
                                      },
                                      child: const Text(
                                        "delete",
                                        style: greenColored,
                                      ),
                                      backgroundColor: green,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        thickness: .5,
                        height: .5,
                        color: brightgreen,
                      ),
                  itemCount: snapshot.data!.length);
            }));
  }
}
