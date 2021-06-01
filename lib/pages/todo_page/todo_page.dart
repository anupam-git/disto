import 'package:disto/pages/todo_page/todo_item_dto.dart';
import 'package:disto/pages/todo_page/todo_item_widget.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final List<TodoItemDTO> data;

  @override
  void initState() {
    super.initState();

    data = List.generate(
      10,
      (index) => new TodoItemDTO(
        value: index.toString(),
      ),
    );
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
                  itemCount: data.length + 1,

                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      // All items created. Create a button to add a todo item

                      return ListTile(
                        onTap: () {
                          setState(() {
                            data.add(
                              new TodoItemDTO(requestFocus: true),
                            );
                          });
                        },
                        leading: Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                          ),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white70,
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
                      return TodoItemWidget(
                        key: UniqueKey(),
                        item: data[index],
                        onDismissed: (direction) {
                          debugPrint(
                            'onDismissed: $index -> ${data[index].value}',
                          );

                          setState(() {
                            TodoItemDTO removedItem = data.removeAt(index);

                            debugPrint(data.toString());

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
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
