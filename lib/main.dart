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

  @override
  void initState() {
    super.initState();
    tasks = <String>[];
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB5C),
        title: const Text('Basic To do List'),
      ),
      body: ListView.separated(itemBuilder: (_, int index){
        return Text('Item $index');
      }, separatorBuilder: (_,int index){
        return const Divider();
      }, itemCount: 100),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffC63D2F),
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void addTask() {
    showDialog(context: context, builder: (_){
return AlertDialog(
      title: Text('Thêm task mới'),
    );
    });
    
  }
}
