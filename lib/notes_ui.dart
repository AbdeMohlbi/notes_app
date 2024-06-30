import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, Object?>> _todos = [];
  List<bool> selectedItems = [];
  final List<String> _suggestions = [];

  Future<void> fetchData() async {}

  @override
  void initState() {
    fetchData();
    _suggestions.addAll(List.generate(10, (index) => 'suggestion $index'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter text',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(20, (index) {
              return Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(8),
                color: Colors.blue,
                child: Center(child: Text('Item $index')),
              );
            }))),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                key: Key('$index'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                leading: Checkbox(
                  value: selectedItems[index],
                  onChanged: (bool? value) {},
                ),
                selected: selectedItems[index],
                onTap: () {
                  setState(() {
                    selectedItems[index] = !selectedItems[index];
                  });
                },
                title: Text(
                  "_todos[index]",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.red),
                ),
                subtitle: Text(
                  "",
                  overflow: TextOverflow.ellipsis,
                ),
                tileColor: Colors.grey.withOpacity(0.6),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        ),
      ],
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final String title;

  SuggestionCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
