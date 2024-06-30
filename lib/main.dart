import 'package:flutter/material.dart';

import 'notes_ui.dart';

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
      home: const AppScreen(),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  AppScreenState createState() => AppScreenState();
}

class AppScreenState extends State<AppScreen> {
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );
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
                    // _todos.add((
                    //   titleController.text,
                    //   descriptionController.text,
                    // ));
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        extendBody: false,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  _pageController.page != 0
                      ? _pageController.animateToPage(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.bounceIn)
                      : null;
                },
                icon: const Icon(
                  Icons.space_dashboard_outlined,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    _pageController.page != 1
                        ? _pageController.animateToPage(1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.bounceIn)
                        : null;
                  },
                  icon: const Icon(
                    Icons.done_all_outlined,
                    color: Colors.orange,
                  )),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    _pageController.page != 2
                        ? _pageController.animateToPage(2,
                            duration: const Duration(seconds: 1),
                            curve: Curves.bounceIn)
                        : null;
                  },
                  icon: const Icon(
                    Icons.settings_rounded,
                    color: Colors.white,
                  )),
            ],
          ),
          backgroundColor: Colors.black,
          elevation: 20,
        ),
        body: PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: [
              const TodoListScreen(),
              Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'RED PAGE',
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.orange,
          onPressed: _addTodo,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
