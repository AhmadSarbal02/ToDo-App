class TaskModel {
  int? id;
  String? msg;
  bool? done;
  bool? archive;
  int? userId;
  TaskModel(
      {required this.id,
      required this.msg,
      required this.done,
      required this.archive,
      required this.userId});

  TaskModel.fromjson({required Map json}) {
    // هندلت الداتا كاملة بالمودل بدل ما اروح لكل  ماب
    // بدل ال
    // list.add(NoteModel(id: i['id'], msg: i['msg']));
    // في النوت كونترولر
    id = json["id"];
    msg = json["msg"];
    done = json["done"] == 1;
    archive = json["archive"] == 1;
    userId = json["userId"];
  }
}

// class TaskModel {
//   final int id;
//   final int userId;
//   final String msg;
//   final bool done;
//   final bool archive;

//   TaskModel(
//       {required this.id,
//       required this.userId,
//       required this.msg,
//       required this.done,
//       required this.archive});

//   factory TaskModel.fromJson(Map<String, dynamic> json) {
//     return TaskModel(
//       id: json['id'],
//       userId: json['userId'],
//       msg: json['msg'],
//       done: json['done'] == 1,
//       archive: json['archive'] == 1,
//     );
//   }
// }
