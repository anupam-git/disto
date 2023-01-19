import 'dart:convert';

import 'package:disto/api/github/github_api.dart';
import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:disto/pages/todo_page/todo_item_widget.dart';
import 'package:disto/util/constants.dart';
import 'package:disto/util/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late GithubApi _api;
  late TodoStore _todoStore;

  @override
  void initState() {
    super.initState();
    _initTodoStore();
  }

  void _initTodoStore() async {
    var prefs = await SharedPreferences.getInstance();
    _api =
        GithubApi.gist(prefs.getString(Constants.preferenceField.accessToken));
    _todoStore = new TodoStore(_api, prefs, []);

    try {
      var json = jsonDecode(prefs.getString(Constants.preferenceField.todos)!);
      setState(() {
        _todoStore.setTodos(
          List<TodoItemDTO>.from(
            json["todos"].map((e) => TodoItemDTO.fromJson(e)),
          ),
        );
      });
    } catch (e) {
      // No todos saved in storage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Colors.purple.shade600,
              Colors.indigo.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                      top: 24,
                      bottom: 24,
                    ),
                    child: Text(
                      'Todos',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  // itemCount is 1 more than length to render the "Add Item" at bottom
                  itemCount: _todoStore.length() + 1,

                  itemBuilder: (context, index) {
                    if (index == _todoStore.length()) {
                      // All items created. Create a button to add a todo item

                      return ListTile(
                        key: UniqueKey(),
                        onTap: () {
                          setState(() {
                            _todoStore.addTodo(
                              new TodoItemDTO(requestFocus: true),
                            );
                          });
                        },
                        leading: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(
                            children: <Widget>[
                              // Place an invisible icon to reserve space for
                              // correct alignment with other items
                              Opacity(
                                opacity: 0,
                                child: Icon(
                                  Icons.drag_indicator,
                                  color: Colors.white38,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          'Add Item',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      );
                    } else {
                      var todo = _todoStore.getTodo(index);

                      return TodoItemWidget(
                        key: UniqueKey(),
                        item: todo,
                        onDismissed: (direction) {
                          debugPrint(
                            'onDismissed: $index -> ${todo.value}',
                          );

                          setState(() {
                            TodoItemDTO removedItem =
                                _todoStore.removeTodo(index);

                            debugPrint(_todoStore.toString());

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(removedItem.value + ' dismissed'),
                              ),
                            );
                          });
                        },
                        onTextChanged: (value) {
                          _todoStore.writeTodos();
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
