class Task {
  int id;
  String title;
  DateTime date;
  String priorty;
  int status; //(0 -> incomplete ; 1 -> complete;)

  Task({
    this.date,
    this.priorty,
    this.status,
    this.title,
  });
  Task.withId({
    this.id,
    this.date,
    this.priorty,
    this.status,
    this.title,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["title"] = title;
    map["date"] = date.toIso8601String();
    map["priorty"] = priorty;
    map["status"] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map["id"],
      title: map["title"],
      date: DateTime.parse(map["date"]),
      priorty: map["priorty"],
      status: map["status"],
    );
  }
}
