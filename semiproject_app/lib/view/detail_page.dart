import 'package:flutter/material.dart';
import 'package:semiproject_app/model/message.dart';
import 'package:semiproject_app/sqlite/database_handler.dart';
import 'package:semiproject_app/sqlite/schedule.dart';

class detailPage extends StatefulWidget {
  const detailPage({super.key});

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController areaController;
  late TextEditingController moneyController;
  late String title;
  late String content;
  late String money;
  late String gdate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // handler.initializeDB().whenComplete(() async {
    //   // await addStudents();
    //   setState(() {
    //     //
    //   });
    // });
    titleController = TextEditingController();
    areaController = TextEditingController();
    moneyController = TextEditingController();
    titleController.text = Message.gtitle;
    areaController.text = Message.gcontent;
    moneyController.text = Message.gmoney;
    gdate = Message.gdate;
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 35, 35),
        title: Image.asset(
          'images/bdlogo.png',
          width: 300,
          height: 50,
        ),
      ),
      body: ColoredBox(
        color: Color.fromARGB(255, 41, 35, 35),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'images/bdaddicon.png',
                    width: 300,
                    height: 300,
                  ),
                  TextField(
                    controller: titleController,
                    // readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: '제목',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[350],
                    ),
                  ),
                  TextField(
                    controller: areaController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: '수익원',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[350],
                    ),
                  ),
                  TextField(
                    controller: moneyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '수익금',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[350],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 61, 48, 48),
                    ),
                    onPressed: () {
                      title = titleController.text;
                      content = areaController.text;
                      money = moneyController.text;
                      _showDialog(context);
                      updateSchedule();
                      // getJSONData();
                    },
                    child: const Text('EDIT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- F
  Future<int> updateSchedule() async {
    Schedule schedule = Schedule(
        id: Message.gid,
        title: titleController.text.trim(),
        content: areaController.text.trim(),
        money: moneyController.text.trim(),
        sdate: gdate);

    await handler.updateSchedule(schedule);

    return 0;
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('수정 결과'),
          content: const Text('수정이 완료 되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
} //END
