class Task {
  int id;
  String title;
  int status;

  Task({
    this.status,
    this.title,
  });
  Task.withId({
    this.id,
    this.status,
    this.title,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["title"] = title;

    map["status"] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map["id"],
      title: map["title"],
      status: map["status"],
    );
  }
}
