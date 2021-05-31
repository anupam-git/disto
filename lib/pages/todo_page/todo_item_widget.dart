import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItemDTO item;
  final Function(bool?)? onCheckedChangeHandler;
  final Function(DismissDirection)? onDismissedHandler;

  TodoItemWidget(
      {required this.item,
      this.onCheckedChangeHandler,
      this.onDismissedHandler});

  @override
  Widget build(BuildContext context) {
    final _textController = new TextEditingController(
      text: item.value,
    );
    final _textDecoration = new InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );

    return Dismissible(
      key: Key(item.value),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      onDismissed: onDismissedHandler,
      child: ListTile(
        leading: Checkbox(
          onChanged: onCheckedChangeHandler,
          value: item.isChecked,
        ),
        title: !item.isChecked
            ? TextField(
                controller: _textController,
                decoration: _textDecoration,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: _textController,
                decoration: _textDecoration,
                style: const TextStyle(
                  color: Colors.white24,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
      ),
    );
  }
}
