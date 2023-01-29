import 'package:path/path.dart';
import 'package:semiproject_app/sqlite/money_for.dart';
import 'package:semiproject_app/sqlite/schedule.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  // Dao랑 비슷하다고 보면 된다.
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'schedules.db'),
      onCreate: (database, version) async {
        await database.execute(
          'create table schedules(id integer primary key autoincrement, title text, content text, money text, sdate text)',
        );
      },
      version: 1,
    );
  }

  // --- C R U D ---

  // Insert
  Future<int> insertSchedule(Schedule schedule) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
        'insert into schedules(title, content, money, sdate) values(?, ?, ?, ?)',
        [schedule.title, schedule.content, schedule.money, schedule.sdate]);

    return result;
  }

  // Select
  Future<List<Schedule>> querySchedules() async {
    // DB 설정하기
    final Database db = await initializeDB();
    // KEY를 가지고와서 사용해야함.
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from schedules order by sdate desc');
    return queryResult.map((e) => Schedule.formMap(e)).toList();
  }

  // SelectDay
  // Select
  Future<List<Schedule>> querySchedulesDay(String sdate) async {
    // DB 설정하기
    final Database db = await initializeDB();
    // KEY를 가지고와서 사용해야함.
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from schedules where sdate = ?', [sdate]);
    return queryResult.map((e) => Schedule.formMap(e)).toList();
  }

  // Delete
  Future<int> deleteSchedule(int id) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawDelete(
      'delete from schedules where id = ?',
      [id],
    );

    return result;
  }

  // Update
  Future<int> updateSchedule(Schedule schedule) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
        'update schedules set title = ?, content = ?, money = ?, sdate = ? where id = ?',
        [
          schedule.title,
          schedule.content,
          schedule.money,
          schedule.sdate,
          schedule.id
        ]);

    return result;
  }

  // Select Money Query
  Future<List<Money>> selectMoney() async {
    // money select 해서 더하기
    // test finish query /select sum(cast(money as signed)) from test_table_mc;
    // DB 설정하기
    final Database db = await initializeDB();
    // KEY를 가지고와서 사용해야함.
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        'select cast(sum(cast(money as signed)) as char) as money from schedules ');
    return queryResult.map((e) => Money.formMap(e)).toList();
  }
} // END
