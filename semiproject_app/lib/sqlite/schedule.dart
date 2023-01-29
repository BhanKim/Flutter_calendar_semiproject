// Model Dart
class Schedule {
  final int? id; //  ? = nullsafty autoincrement라서 ㅇㅇ 값안주고 자동생성이니까 ㅇㅇ
  final String title;
  final String content;
  final String money;
  final String sdate;

  // Constructor
  Schedule({
    this.id,
    required this.title,
    required this.content,
    required this.money,
    required this.sdate,
  });

// dart에서는 중복이름이 안되기 때문에 생성자를 만들어서 쓴다.
  Schedule.formMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        content = res['content'],
        money = res['money'],
        sdate = res['sdate'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'money': money,
      'sdate': sdate
    };
  }
}
