import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'note_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp()); //若只要return一項可以把return改成=>

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _titleController;
  late ScrollController _descriptionController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _titleController = _controllers.addAndGet();
    _descriptionController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //move to constants.cart
    //const TextStyle kTextStyle = TextStyle(fontSize: 30, color: Color(0xEEFFEEFF));
    //const TextStyle kDesTextStyle = TextStyle(fontSize: 23, color: Color(0xEEFFEEFF));
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              {
                noteList.add(['title', 'description']);
              }
              print(noteList.length);
            });
          },
        ),
        appBar: AppBar(title: const Text('Flutter Week2')),
        body: Row(
          //左右欄位
          children: [
            Expanded(
              child: ListView.builder(
                controller: _titleController,
                itemCount: noteList.length, //除法取整數
                itemBuilder: (context, index) {
                  final listIndex = index;
                  final note = noteList[listIndex];
                  return NoteCard(
                    title: note[0],
                    description: note[1],
                    index: listIndex,
                    remove: () {
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  //若可寫入NULL 則不需要加入required
  const NoteCard({
    super.key,
    required this.title,
    required this.description,
    required this.index,
    required this.remove,
  });

  //final String? title;//可以寫入NULL的string
  final String title;
  final String description;
  final int index;
  final VoidCallback remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(9),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(colorPool[index % colorPool.length]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text(title ??'default_T', style: kTitleTextStyle),//若NULL則寫入default
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: kTextStyle),
              IconButton(
                onPressed: remove,
                icon: Icon(FontAwesomeIcons.trash, color: Colors.grey),
              ),
            ],
          ),
          Text(description, style: kDesTextStyle),
        ],
      ),
    );
  }
}
/*
git+(以下指令)
init
add . //僅加入目前路徑以下
add --all//加入所有
commit -m"message"
status
log
log --oneline//用一行的形式顯示
push//推到網路端
pull
 */