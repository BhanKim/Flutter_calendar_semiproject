import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:semiproject_app/sqlite/schedule.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:semiproject_app/sqlite/database_handler.dart';

class addPage extends StatefulWidget {
  const addPage({Key? key}) : super(key: key);

  @override
  State<addPage> createState() => _addPageState();
}

class _addPageState extends State<addPage> {
  // 오늘 날짜 표시
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  // 해당 날짜에 리스트 추가하기위하여 변수선언.
  Map<String, List> mySelectedEvents = {};

  // 선언부
  late TextEditingController titleController;
  late TextEditingController areaController;
  late TextEditingController moneyController;
  late DatabaseHandler handler;
  late String insertSelectedate;
  // seleted day
  late String selectedDay1;
  // 선택한 날짜
  // void _ondaySelected(DateTime day, DateTime focusedDay) {
  //   setState(() {
  //     today = day;
  //   });
  // }

  // initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    areaController = TextEditingController();
    moneyController = TextEditingController();
    _selectedDate = _focusedDay;
    handler = DatabaseHandler();
    selectedDay1 = '';
    getAll();
    handler.initializeDB().whenComplete(
      () async {
        setState(() {});
      },
    );
    // insertSelectedate = _focusedDay.toString().split(" ")[0];

    // loadPreviousEvents();
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: calendars(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   height: 1000,
                  //   child: FutureBuilder(
                  //     future: handler.querySchedulesDay(selectedDay1),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<List<Schedule>> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return ListView.builder(
                  //           itemCount: snapshot.data?.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 // ---
                  //               },
                  //               child: Card(
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         const Text('Date : '),
                  //                         Text(snapshot.data![index].sdate),
                  //                       ],
                  //                     ),
                  //                     Row(
                  //                       children: [
                  //                         const Text('Title : '),
                  //                         Text(snapshot.data![index].title),
                  //                       ],
                  //                     ),
                  //                     Row(
                  //                       children: [
                  //                         const Text('Area : '),
                  //                         Text(snapshot.data![index].content),
                  //                       ],
                  //                     ),
                  //                     Row(
                  //                       children: [
                  //                         const Text('Money : '),
                  //                         Text(snapshot.data![index].money),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       } else {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Schedule'),
      ),
    );
  }

  // --- Widget ---
  Widget calendars() {
    return Column(
      children: [
        TableCalendar(
          locale: 'ko_KR',
          // calendar 꾸미기
          calendarStyle: const CalendarStyle(
            // 오늘날짜 꾸미기
            todayTextStyle: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
            todayDecoration: BoxDecoration(
              color: Color.fromARGB(134, 61, 48, 48),
              shape: BoxShape.circle,
            ),
            // selectedDay 글자 조정
            selectedTextStyle: TextStyle(
              color: Colors.amber,
              // fontSize: 16.0,
            ),

            // selectedDay 모양 조정
            selectedDecoration: BoxDecoration(
              color: Color.fromARGB(255, 61, 48, 48),
              shape: BoxShape.circle,
            ),
            // weekend 글자 조정
            weekendTextStyle: TextStyle(color: Colors.red),
            // weekend 모양 조정
            weekendDecoration: BoxDecoration(shape: BoxShape.circle),
            // 달력 내부모양
            // rowDecoration:
            //     BoxDecoration(color: Color.fromARGB(255, 178, 164, 142)),
          ),
          rowHeight: 60,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          // availableGestures: AvailableGestures.all,
          // 날짜 선택하기.
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDate, selectedDay)) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDay = focusedDay;
                selectedDay1 = DateFormat('yyyy-MM-dd').format(focusedDay);
              });
            }
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _listOfDayEvents,
        ),
        // ORIGIN
        ..._listOfDayEvents(_selectedDate!).map(
          (myEvents) => ListTile(
            leading: const Icon(
              Icons.done,
            ),
            title: Text('제목 : ${myEvents['EventTitle']}'),
            subtitle: Text(
                '내용 : ${myEvents['EventContent']}\n수익금 : ${myEvents['EventMoney']}'),
          ),
        ),
        // END
      ],
    );
  }

  // --- Functions ---

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Schedule',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: areaController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Where you got money',
                ),
              ),
              TextField(
                controller: moneyController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Money of Day',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // Add Event
              addSchedule();
              if (titleController.text.trim().isEmpty &&
                  areaController.text.trim().isEmpty &&
                  moneyController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('입력확인 바랍니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                // print(titleController.text);
                // print(areaController.text);
                // print(moneyController.text);

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      'EventTitle': titleController.text,
                      'EventContent': areaController.text,
                      'EventMoney': moneyController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        'EventTitle': titleController.text,
                        'EventContent': areaController.text,
                        'EventMoney': moneyController.text,
                      }
                    ];
                  }
                });

                // print(
                //     "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                areaController.clear();
                moneyController.clear();
                Navigator.pop(context);
                return;
              }
            },
            child: const Text('입력'),
          ),
        ],
      ),
    );
  }

  // 2022-12-26
  // 일정 등록 하였을 시 캘린더에 갯수 표시하는 함수
  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  // --- Insert Query ---
  Future<int> addSchedule() async {
    Schedule schedule = Schedule(
        title: titleController.text.trim(),
        content: areaController.text.trim(),
        money: moneyController.text.trim(),
        sdate: _selectedDate.toString().split(' ')[0]);
    await handler.insertSchedule(schedule);

    return 0;
  }

  // 임의값 저장 함수
  loadPreviousEvents() {
    mySelectedEvents = {
      "2022-12-26": [
        {
          'EventContent': '11',
          'EventMoney': '222',
          'EventTitle': '111',
        },
      ],
      "2022-12-29": [
        {
          'EventContent': '11',
          'EventMoney': '222',
          'EventTitle': '111',
        },
      ]
    };
  }

  // test1() {
  //   FutureBuilder(
  //     future: handler.querySchedules(),
  //     builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemCount: snapshot.data?.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return mySelectedEvents = {snapshot.data![index].sdate: [
  //               {
  //                 'EventTitle' : snapshot.data![index].title,
  //                 'EventMoney' : snapshot.data![index].money,
  //                 'EventContent' : snapshot.data![index].content,

  //               },
  //             ],
  //             };
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  test() {
    FutureBuilder(
      future: handler.querySchedules(),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // ---
                },
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Date : '),
                          Text(snapshot.data![index].sdate),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Title : '),
                          Text(snapshot.data![index].title),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Area : '),
                          Text(snapshot.data![index].content),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Money : '),
                          Text(snapshot.data![index].money),
                        ],
                      ),
                    ],
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
    );
  }

  void getAll() {
    Future<List<Schedule>> listFuture;
    listFuture = handler.querySchedules();
    listFuture.then((value) {
      for (var i in value) {
        if (mySelectedEvents[i.sdate] != null) {
          mySelectedEvents[i.sdate]?.add({
            "EventTitle": i.title,
            "EventContent": i.content,
            "EventMoney": i.money,
          });
        } else {
          mySelectedEvents[i.sdate] = [
            {
              "EventTitle": i.title,
              "EventContent": i.content,
              "EventMoney": i.money,
            }
          ];
        }
      }
    });
  }
} // END