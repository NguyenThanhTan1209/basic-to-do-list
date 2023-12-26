import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<String> tasks;
  final TextEditingController inputController = TextEditingController();
  String newDialogType = 'newDialogType';
  String editDialogType = 'editDialogType';

  @override
  void initState() {
    super.initState();
    tasks = <String>[];
  }

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  void addTask() {
    final String newTask = inputController.text;
    if (newTask.isEmpty) {
      return;
    }
    setState(() {
      tasks.add(newTask);
    });
    inputController.clear();
    Navigator.of(context).pop();
  }

  void editTask({required int index}) {
    final String editTask = inputController.text;
    if (editTask.isEmpty) {
      return;
    }
    setState(() {
      tasks[index] = editTask;
    });
    inputController.clear();
    Navigator.of(context).pop();
  }

  void deleteTask({required int index}) {
    setState(() {
      tasks.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  void closeDialog() {
    inputController.clear();
    Navigator.of(context).pop();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB5C),
        title: const Text('Basic To do List'),
      ),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          return ListTile(
            title: Text(tasks[index]),
            onTap: () => showTaskDialog(
                dialogType: editDialogType,
                inputValue: tasks[index],
                index: index),
            trailing: IconButton(
              onPressed: () => showDeleteTask(index),
              icon: const Icon(Icons.delete_forever_rounded),
            ),
          );
        },
        separatorBuilder: (_, int index) {
          return const Divider();
        },
        itemCount: tasks.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC63D2F),
        onPressed: () => showTaskDialog(dialogType: newDialogType),
        child: const Icon(Icons.add),
      ),
    );
  }

  void showTaskDialog(
      {required String dialogType, String inputValue = '', int index = -1}) {
    inputController.text = inputValue;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: dialogType == newDialogType
              ? const Text('Thêm task mới')
              : const Text('Chỉnh sửa task'),
          content: TextField(
            autofocus: true,
            controller: inputController,
            decoration: InputDecoration(
              hintText: 'Nhập công việc của bạn',
              labelText: dialogType == newDialogType ? 'Công việc mới' : '',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: closeDialog,
              style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xffC63D2F),
                  side: const BorderSide(
                    width: 0.5,
                    color: Color(0xffC63D2F),
                  )),
              child: const Text('Huỷ'),
            ),
            ElevatedButton(
              onPressed: () {
                if (dialogType == newDialogType) {
                  addTask();
                } else {
                  editTask(index: index);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffC63D2F),
              ),
              child: const Text('Lưu'),
            )
          ],
        );
      },
    );
  }

  void showDeleteTask(int index) {
    final String task = tasks[index];
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Xoá công việc'),
          content: Text('Bạn có chắc chắn muốn xoá task "$task" không?'),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xffC63D2F),
                  side: const BorderSide(
                    width: 0.5,
                    color: Color(0xffC63D2F),
                  ),
                ),
                child: const Text('Không')),
            ElevatedButton(
                onPressed: () => deleteTask(index: index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC63D2F),
                ),
                child: const Text('Có')),
          ],
        );
      },
    );
  }
}
