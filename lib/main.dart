import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  List<(String, String)> _todos = [];
  List<bool> selectedItems = [];
  Future<void> fetchData() async {}
  void _addTodo() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.add),
          title: const Text('New To-Do'),
          scrollable: true,
          alignment: Alignment.center,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "to-do title", counterText: "title"),
              ),
              TextField(
                  maxLines: null,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: "to-do description",
                      counterText: "description")),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Add'),
                onPressed: () {
                  setState(() {
                    _todos.add((
                      titleController.text,
                      descriptionController.text,
                    ));
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      extendBody: false,
      appBar: AppBar(
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 20,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter text',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
          ),
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
                    _todos[index].$1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(
                    _todos[index].$2,
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
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.orange,
        onPressed: _addTodo
        // await DatabaseHelper.addNote(("somthing bad", "somthing worst"));
        // print(await DatabaseHelper.fetchAllNotes());
        // print(await DatabaseHelper.updateNote((11, "new", "new ")));
        // print(await DatabaseHelper.fetchAllNotes());
        // print(await DatabaseHelper.deleteOneNote(1));
        // await DatabaseHelper.fetchAllNotes();
        // print(await DatabaseHelper.deleteAllNotes());
        // await DatabaseHelper.fetchAllNotes();
        ,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
