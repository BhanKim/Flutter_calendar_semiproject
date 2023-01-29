// Model Dart
class Money {
  final String moneytotal;

  // Constructor
  Money({
    required this.moneytotal,
  });

// dart에서는 중복이름이 안되기 때문에 생성자를 만들어서 쓴다.
  Money.formMap(Map<String, dynamic> res) : moneytotal = res['money'];

  Map<String, Object?> toMap() {
    return {'money': moneytotal};
  }
}
