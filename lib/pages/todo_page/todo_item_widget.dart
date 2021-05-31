import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItemDTO item;
  final Function(bool?)? onCheckedChange;
  final Function(DismissDirection)? onDismissed;
  final Function(String)? onTextChanged;

  final bool requestFocus;

  TodoItemWidget({
    required this.item,
    this.requestFocus = false,
    this.onCheckedChange,
    this.onDismissed,
    this.onTextChanged,
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

    final _textFieldFocusNode = new FocusNode();

    if (requestFocus) {
      _textFieldFocusNode.requestFocus();
    }

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
        if (onDismissed != null) {
          onDismissed!(direction);
        }
      },
      child: ListTile(
        leading: Container(
          height: double.infinity,
          child: Checkbox(
            onChanged: (value) {
              if (onCheckedChange != null) {
                onCheckedChange!(value);
              }
            },
            value: item.isChecked,
          ),
        ),
        title: !item.isChecked
            ? TextField(
                controller: _textController,
                decoration: _textDecoration,
                focusNode: _textFieldFocusNode,
                onChanged: (value) {
                  if (onTextChanged != null) {
                    onTextChanged!(value);
                  }
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: _textController,
                decoration: _textDecoration,
                focusNode: _textFieldFocusNode,
                onChanged: (value) {
                  if (onTextChanged != null) {
                    onTextChanged!(value);
                  }
                },
                style: const TextStyle(
                  color: Colors.white24,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
      ),
    );
  }
}
