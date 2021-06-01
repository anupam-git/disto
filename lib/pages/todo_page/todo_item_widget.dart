import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItemDTO item;
  final Function(DismissDirection)? onDismissed;

  TodoItemWidget({
    Key? key,
    required this.item,
    this.onDismissed,
  }) : super(key: key);

  @override
  _TodoItemWidgetState createState() => new _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late final _textFieldFocusNode;
  late final _textController;
  late final _textDecoration;

  @override
  void initState() {
    super.initState();

    _textFieldFocusNode = new FocusNode();

    _textController = new TextEditingController(
      text: widget.item.value,
    );

    _textDecoration = new InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.requestFocus) {
      _textFieldFocusNode.requestFocus();
      widget.item.requestFocus = false;
    }

    return Dismissible(
      key: Key(widget.item.value),
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
        if (widget.onDismissed != null) {
          widget.onDismissed!(direction);
        }
      },
      child: ListTile(
        leading: Container(
          height: double.infinity,
          child: Checkbox(
            onChanged: (value) {
              setState(() {
                widget.item.isChecked = value!;
              });
            },
            value: widget.item.isChecked,
          ),
        ),
        title: !widget.item.isChecked
            ? TextField(
                controller: _textController,
                decoration: _textDecoration,
                focusNode: _textFieldFocusNode,
                onChanged: (value) {
                  widget.item.value = value;
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
                  widget.item.value = value;
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
