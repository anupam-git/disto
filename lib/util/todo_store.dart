import 'dart:convert';

import 'package:disto/api/github/github_api.dart';
import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:disto/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoStore {
  late final List<TodoItemDTO> _todos;
  final SharedPreferences _prefs;

  TodoStore(GithubApi api, this._prefs, this._todos);

  void setTodos(List<TodoItemDTO> todos) {
    _todos = todos;
  }

  int length() {
    return _todos.length;
  }

  void addTodo(TodoItemDTO item) {
    _todos.add(item);
  }

  TodoItemDTO getTodo(int index) {
    return _todos[index];
  }

  TodoItemDTO removeTodo(int index) {
    return _todos.removeAt(index);
  }

  void writeTodos() async {
    _prefs.setString(
      Constants.preferenceField.todos,
      jsonEncode({
        'todos': this._todos,
      }),
    );
  }
}
