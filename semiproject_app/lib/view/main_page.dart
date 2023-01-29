import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:semiproject_app/login/welcome.dart';
import 'package:semiproject_app/model/message.dart';
import 'package:semiproject_app/sqlite/database_handler.dart';
import 'package:semiproject_app/sqlite/money_for.dart';
import 'package:semiproject_app/sqlite/schedule.dart';
import 'package:semiproject_app/view/add_page.dart';
import 'package:semiproject_app/view/boss_page.dart';
import 'package:semiproject_app/view/detail_page.dart';
import 'package:semiproject_app/view/my_page.dart';
import 'package:semiproject_app/view/web_page.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  late DatabaseHandler handler;
  late List data;
  late String totalmoney;
  // late String totalMoney;
  var formed = NumberFormat('###,###,###,###');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    totalmoney = '';
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      // await addStudents();
      setState(() {
        //
        totals();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/bdlogo.png',
          width: 300,
          height: 50,
        ),
        backgroundColor: const Color.fromARGB(255, 41, 35, 35),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const addPage();
                },
              )).then((value) => getUserData());
              // Test Calendar
              // const EventCalendarScreen(),
            },
            icon: Image.asset(
              'images/bdboxing.gif',
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     // print(formed.format(100000000000));
          //     // totals();
          //     Get.to(const welcomePage());
          //   },
          //   icon: Image.asset(
          //     'images/bdaddicon.png',
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 61, 48, 48),
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: UserAccountsDrawerHeader(
            //     accountName: Text(
            //       'userNick 님',
            //       style: TextStyle(
            //         color: Colors.grey[350],
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //     accountEmail: Text(
            //       'userEmail',
            //       style: TextStyle(
            //         color: Colors.grey[350],
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15,
            //       ),
            //     ),
            //     currentAccountPicture: const CircleAvatar(
            //       radius: 40,
            //       backgroundImage: AssetImage('images/bdappicon.webp'),
            //     ),
            //     decoration: const BoxDecoration(
            //       color: Color.fromARGB(255, 61, 48, 48),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'images/bdappicon.webp',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'userNick',
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'userEmail',
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.web_asset,
                    color: Colors.grey[350],
                  ),
                  Text(
                    '   Web Site',
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Get.to(const webPage());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey[350],
                  ),
                  Text(
                    '   Mypage',
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const myPage();
                  },
                )).then((value) => getUserData());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey[350],
                  ),
                  Text(
                    '   Boss Calendar',
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const bossPage();
                  },
                )).then((value) => getUserData());
              },
            ),
          ],
        ),
      ),
      body: ColoredBox(
        color: Color.fromARGB(255, 41, 35, 35),
        child: Column(
          children: [
            Image.asset(
              'images/bdsilvercoin.png',
              width: 130,
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '총 수익금(예상수익포함)  :  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    '$totalmoney 은화',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 195, 44, 44),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: handler.querySchedules(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Schedule>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Delete
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Color.fromARGB(255, 41, 35, 35),
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete_forever,
                              color: Color.fromARGB(255, 206, 186, 0),
                            ),
                          ),
                          key: ValueKey(snapshot.data![index]),
                          onDismissed: (DismissDirection direction) async {
                            await handler
                                .deleteSchedule(snapshot.data![index].id!);
                            setState(() {
                              totals();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(const detailPage());
                              // updatePage
                              Message.gid = snapshot.data![index].id!;
                              Message.gtitle = snapshot.data![index].title;
                              Message.gcontent = snapshot.data![index].content;
                              Message.gmoney = snapshot.data![index].money;
                              Message.gdate = snapshot.data![index].sdate;
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const detailPage();
                                },
                              )).then((value) => getUserData());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                child: ColoredBox(
                                  color: Color.fromARGB(240, 61, 48, 48),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date : ',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].sdate,
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Title : ',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 17,
                                                letterSpacing: 1,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].title,
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Area : ',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].content,
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Money : ',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Text(
                                              '${formed.format(int.parse(snapshot.data![index].money))} 은화',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 189, 165, 79),
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Fuctions ---
  getUserData() {
    setState(() {
      handler.querySchedules();
      totals();
    });
  }

  // total Money
  Future<void> totals() async {
    List<Money> listmoney;
    listmoney = (await handler.selectMoney());
    // listmoney.then((value) {
    setState(() {
      totalmoney = formed.format(int.parse(listmoney[0].moneytotal));
      print(totalmoney);
      // });
    });
  }
} // END
