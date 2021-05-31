import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItemDTO item;
  final Function(bool?)? onCheckedChangeHandler;
  final Function(DismissDirection)? onDismissedHandler;
  final Function(bool)? onFocusChanged;

  TodoItemWidget({
    required this.item,
    this.onCheckedChangeHandler,
    this.onDismissedHandler,
    this.onFocusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final _textController = new TextEditingController(
      text: item.value,
    );
    final _textDecoration = new InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );

    final _focusNode = new FocusNode();
    _focusNode.addListener(() {
      if (onFocusChanged != null) {
        onFocusChanged!(_focusNode.hasFocus);
      }
    });

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
      onDismissed: (direction) {
        if (onDismissedHandler != null) {
          onDismissedHandler!(direction);
        }
      },
      child: ListTile(
        leading: Container(
          height: double.infinity,
          child: Checkbox(
            onChanged: (value) {
              if (onCheckedChangeHandler != null) {
                onCheckedChangeHandler!(value);
              }
            },
            value: item.isChecked,
          ),
        ),
        title: !item.isChecked
            ? TextField(
                controller: _textController,
                decoration: _textDecoration,
                focusNode: _focusNode,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: _textController,
                decoration: _textDecoration,
                focusNode: _focusNode,
                style: const TextStyle(
                  color: Colors.white24,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
      ),
    );
  }
}
