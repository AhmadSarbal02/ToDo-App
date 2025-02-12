import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqfliteDb {
  static Database? _db;

  // عشان اشوف اذا معمول انيشيل للداتا بيس ولا لا ,اذا معمول والداتابيس مش فاضيه خلص لا تعمل ,اذا فاضيه معناته مش معمول واعمل , وهذا الاشي بعمله من خلال المتغير
  // _db
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

//  عمل انيشيلايز للداتا بيس
  intialDb() async {
    //قاعدة بيانات محلية مش هوستنج , فبالتالي محتاج احدد المسار الي رح تنحفظفيه هاي القاعدة
    String databasePath = await getDatabasesPath();
    //ربط المسار بأسم قاعدة البيانات
    String path = join(databasePath,
        'taskkkk.db'); // الجوين بس بتضيف باك سلاش وبتجيب المسار من الداتا بيس باث
    // database_path/task.db

    // فتح قاعدة البيانات وبدأ انشاء الجداول
    Database mydb = await openDatabase(path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade:
            _onUpgrade); // يتم استدعاء الاون كرييت مره وحده عند انشاء الجدول فقط او عند تغيير الفيرجين او عن طريق الابجريد
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    // ignore: avoid_print
    print("_onUpgrade======================================================");
  }

  // انشاء الجداول عن طريق الاكسكيوت
  _onCreate(Database db, int version) async {
    // الثلاث كوتيشن عشان اقدر انزل بتعلمية السكيول براحتي واكتبها على اكثر منسطر
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT NOT NULL UNIQUE,
        password TEXT
      )
    ''');

    await db.execute(
        'CREATE TABLE task (id INTEGER PRIMARY KEY, msg TEXT, done BOOLEAN, archive BOOLEAN)');

    // ignore: avoid_print
    print(
        "Created users tabel ============================================================================================= ");
  }

  // عشان اعادة الاستخدام طلبت سترينج سكيول
  getData({required String sql}) async {
    // هون فائدةالتحقق من الانيشيل , قبل ما يتعامل مع ماي دي بي رح يروح يشوف اذا الدي بي معموللها انيشيليز ولا لا معمول تمام كمل مش معمول اعمل , لوما بعمل تحقق رحيعمل انيشلايزبكل مره وبالابديت والديليت و و و
    Database? mydb = await db;
    // رو كويري بترجعلي ليست , شوف بعينك وتأكد , عشان هيك حطيت الريسبونس من نوع ليست اوف ماب
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData({required String sql}) async {
    Database? mydb = await db;
    //رو انسيريت بترجعلي صفر او قيمة الرو المضاف , برضو شوف وتأكد بعينك , عشان هيك الريسبونس نوعه انتيجر
    //بترجع صفر اذا فشلت العملية ونفس الاشي الابديت والديليت
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData({required String sql}) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData({required String sql}) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  loginUser({required String email, required String password}) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty; // إذا كان هناك بيانات، فالمستخدم موجود
  }
}
