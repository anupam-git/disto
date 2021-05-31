import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:disto/pages/todo_page/todo_item_widget.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  List<TodoItemDTO> data =
      List.generate(10, (index) => new TodoItemDTO(index.toString(), false));

  TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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
                  itemCount: widget.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.data.length) {
                      // All items created. Create a placeholder item for
                      // new todo

                      TodoItemDTO item = new TodoItemDTO('', false);

                      return TodoItemWidget(
                        item: item,
                        onFocusChanged: (hasFocus) {
                          print(hasFocus);
                        },
                      );
                    } else {
                      return TodoItemWidget(
                        item: widget.data[index],
                        onCheckedChangeHandler: (value) {
                          setState(() {
                            widget.data[index].isChecked = value!;
                          });
                        },
                        onDismissedHandler: (direction) {
                          setState(() {
                            TodoItemDTO removedItem =
                                widget.data.removeAt(index);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(milliseconds: 500),
                                content: Text(removedItem.value + ' dismissed'),
                              ),
                            );
                          });
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
