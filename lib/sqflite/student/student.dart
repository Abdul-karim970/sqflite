import 'dart:convert';

class Student {
  String name;
  int rollNo;
  double fee;

  Student(
    this.name,
    this.rollNo,
    this.fee,
  );

  static const tableName = 'Student';
  static const colRollNo = 'rollNo';
  static const colName = 'name';
  static const colFee = 'fee';
  static const createTable =
      'CREATE TABLE IF NOT EXISTS $tableName ($colRollNo INTEGER PRIMARY KEY, $colName TEXT, $colFee REAL)';
  static const dropTable = 'DROP TABLE IF EXISTS $tableName';

  Student copyWith({
    String? name,
    int? rollNo,
    double? fee,
  }) {
    return Student(
      name ?? this.name,
      rollNo ?? this.rollNo,
      fee ?? this.fee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rollNo': rollNo,
      'fee': fee,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['name'] as String,
      map['rollNo'] as int,
      map['fee'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Student(name: $name, rollNo: $rollNo, fee: $fee)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.name == name && other.rollNo == rollNo && other.fee == fee;
  }

  @override
  int get hashCode => name.hashCode ^ rollNo.hashCode ^ fee.hashCode;
}
