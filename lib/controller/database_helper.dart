// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:todo/model/task_model.dart';

// class DatabaseHelper {
//   static Database? _database;
//   static final DatabaseHelper instance = DatabaseHelper._init();

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), 'task.db');
//     return _database =
//         await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE users (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         email TEXT UNIQUE,
//         password TEXT,
//         name TEXT
//       )
//     ''');
//     print("تمممممممممممممممممممممم انشاء جدوووول اليوووووزر");
//   }

//   insertUser(
//       {required String email,
//       required String password,
//       required String name}) async {
//     await _database!
//         .insert('users', {'email': email, 'password': password, 'name': name});
//   }

//   Future<bool> loginUser(
//       {required String email, required String password}) async {
//     List<Map<String, dynamic>> result = await _database!.query(
//       'users',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );
//     return result.isNotEmpty; // إذا كان هناك بيانات، فالمستخدم موجود
//   }

//   // Future<int> insertUser(String email, String password, String name) async {
//   //   final db = await database;
//   //   return await db
//   //       .insert('users', {'email': email, 'password': password, 'name': name});

//   // }

//   // Future<Map<String, dynamic>?> getUser(String email, String password) async {
//   //   final db = await database;
//   //   List<Map<String, dynamic>> result = await db.query(
//   //     'users',
//   //     where: 'email = ? AND password = ?',
//   //     whereArgs: [email, password],
//   //   );
//   //   return result.isNotEmpty ? result.first : null;
//   // }

//   // Future<int> insertTask(int userId, String msg) async {
//   //   final db = await database;
//   //   return await db.insert('tasks', {
//   //     'userId': userId,
//   //     'msg': msg,
//   //     'done': 0,
//   //     'archive': 0,
//   //   });
//   // }

//   // Future<void> updateTaskStatus(int taskId, bool done) async {
//   //   final db = await database;
//   //   await db.update(
//   //     'tasks',
//   //     {'done': done ? 1 : 0},
//   //     where: 'id = ?',
//   //     whereArgs: [taskId],
//   //   );
//   // }

//   // Future<void> archiveTask(int taskId, bool archive) async {
//   //   final db = await database;
//   //   await db.update(
//   //     'tasks',
//   //     {'archive': archive ? 1 : 0},
//   //     where: 'id = ?',
//   //     whereArgs: [taskId],
//   //   );
//   // }

//   // Future<void> deleteTask(int taskId) async {
//   //   final db = await database;
//   //   await db.delete(
//   //     'tasks',
//   //     where: 'id = ?',
//   //     whereArgs: [taskId],
//   //   );
//   // }

//   // getUserTasks(int userId) async {
//   //   final db = await database;
//   //   return await db.query(
//   //     'tasks',
//   //     where: 'userId = ?',
//   //     whereArgs: [userId],
//   //   );

//   // }
// }

// // import 'package:sqflite/sqflite.dart';
// // import 'package:path/path.dart';

// // import '../model/task_model.dart';
// // import '../model/user_model.dart';
// // class DatabaseHelper {
// //   static Database? _database;
// //   static final DatabaseHelper instance = DatabaseHelper._init();
  
// //   DatabaseHelper._init();

// //   Future<Database> get database async {
// //     if (_database != null) return _database!;
// //     _database = await _initDB();
// //     return _database!;
// //   }

// //   Future<Database> openDatabaseFile() async {
// //     String path = join(await getDatabasesPath(), 'task.db');
// //     return await openDatabase(path, version: 1, onCreate: _createDB);
// //   }

// //   Future<void> _createDB(Database db, int version) async {
// //     await db.execute('''
// //       CREATE TABLE users (
// //         id INTEGER PRIMARY KEY AUTOINCREMENT,
// //         email TEXT UNIQUE,
// //         password TEXT,
// //         name TEXT
// //       )
// //     ''');
// //     await db.execute('''
// //       CREATE TABLE tasks (
// //         id INTEGER PRIMARY KEY AUTOINCREMENT,
// //         userId INTEGER,
// //         msg TEXT,
// //         done BOOLEAN DEFAULT 0,
// //         archive BOOLEAN DEFAULT 0,
// //         FOREIGN KEY (userId) REFERENCES users(id)
// //       )
// //     ''');
// //   }
  
// //   // إضافة مستخدم جديد
//   //   Future<int> insertUser(String email, String password, String name) async {
//   //   final db = await database;
//   //   return await db
//   //       .insert('users', {'email': email, 'password': password, 'name': name});

//   // }

// //   // جلب بيانات المستخدم عند تسجيل الدخول
// //   Future<UserModel?> getUser(String email, String password) async {
// //     final db = await database;
// //     List<Map<String, dynamic>> result = await db.query(
// //       'users',
// //       where: 'email = ? AND password = ?',
// //       whereArgs: [email, password],
// //     );
// //     return result.isNotEmpty ? UserModel.fromJson(result.first) : null;
// //   }

// //   // إضافة مهمة جديدة
// //   Future<int> insertTask(TaskModel task) async {
// //     final db = await database;
// //     return await db.insert('tasks', {
// //       'userId': task.userId,
// //       'msg': task.msg,
// //       'done': task.done ? 1 : 0,
// //       'archive': task.archive ? 1 : 0,
// //     });
// //   }

// //   // تحديث حالة المهمة (مكتملة أو مؤرشفة)
// //   Future<void> updateTaskStatus(int taskId, {bool? done, bool? archive}) async {
// //     final db = await database;
// //     Map<String, dynamic> updateValues = {};
// //     if (done != null) updateValues['done'] = done ? 1 : 0;
// //     if (archive != null) updateValues['archive'] = archive ? 1 : 0;
// //     await db.update('tasks', updateValues, where: 'id = ?', whereArgs: [taskId]);
// //   }

// //   // جلب جميع المهام الخاصة بمستخدم معين بناءً على حالتها
// //   Future<List<TaskModel>> getUserTasks(int userId, {bool? done, bool? archive}) async {
// //     final db = await database;
// //     String whereClause = 'userId = ?';
// //     List<dynamic> whereArgs = [userId];
    
// //     if (done != null) {
// //       whereClause += ' AND done = ?';
// //       whereArgs.add(done ? 1 : 0);
// //     }
// //     if (archive != null) {
// //       whereClause += ' AND archive = ?';
// //       whereArgs.add(archive ? 1 : 0);
// //     }
    
// //     List<Map<String, dynamic>> result = await db.query('tasks', where: whereClause, whereArgs: whereArgs);
// //     return result.map((e) => TaskModel.fromJson(e)).toList();
// //   }
// // }
