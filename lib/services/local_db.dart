import 'package:path/path.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  Future<String> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = join(dbPath, 'sikoopi.db');

    return path;
  }

  Future<Database> openDB () async {
    String path = await initDB();

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, address TEXT, email TEXT, pass TEXT, role TEXT)',
      );

      await db.execute(
        'CREATE TABLE training (id INTEGER PRIMARY KEY, date TEXT, hour TEXT, participant INTEGER, speaker TEXT)',
      );

      await db.execute(
        'CREATE TABLE training_participant (id INTEGER PRIMARY KEY, training_id INTEGER, user_id INTEGER, certificate_status TEXT)',
      );

      // Insert initial data
      await db.execute(
        'INSERT INTO user (name, phone, email, pass, role) VALUES (?, ?, ?, ?, ?)',
        [
          'Admin Dika',
          '082322196306',
          'dika.siqurol@gmail.com',
          'p4ssw0rd',
          'admin',
        ],
      );

      await db.execute(
        'INSERT INTO user (name, phone, address, email, pass, role) VALUES (?, ?, ?, ?, ?, ?)',
        [
          'Test User',
          '0123456789',
          'Test Address',
          'user.test@siqurol.com',
          'p4ssw0rd',
          'user',
        ],
      );
    });

    return database;
  }

  // WRITE
  Future<List> writeUser(AuthData auth) async {
    bool result = false;
    int? userId;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO user (name, phone, email, address, pass, role) VALUES (?, ?, ?, ?, ?, ?)',
        [
          auth.name,
          auth.phone,
          auth.email,
          auth.address,
          auth.password,
          auth.role,
        ],
      ).then((id) {
        result = true;
        userId = id;
      });
    });

    return [result, userId];
  }

  // READ
  Future<List<AuthData>> readAllUser() async {
    List<AuthData> atuhList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            atuhList.add(
              AuthData(
                userId: int.parse("${result[i]['id']}"),
                email: "${result[i]['email']}",
                password: "${result[i]['pass']}",
                name: "${result[i]['name']}",
                phone: "${result[i]['phone']}",
                address: "${result[i]['address']}",
                role: "${result[i]['role']}",
              ),
            );
          }
        }
      });
    });

    return atuhList;
  }

  Future<List<AuthData>> readOnlyUserRole() async {
    List<AuthData> atuhList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        "SELECT * FROM user WHERE role = 'user'",
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            atuhList.add(
              AuthData(
                userId: int.parse("${result[i]['id']}"),
                email: "${result[i]['email']}",
                password: "${result[i]['pass']}",
                name: "${result[i]['name']}",
                phone: "${result[i]['phone']}",
                address: "${result[i]['address']}",
                role: "${result[i]['role']}",
              ),
            );
          }
        }
      });
    });

    return atuhList;
  }

  Future<AuthData?> readUser(int id) async {
    AuthData? auth;

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user WHERE id = ?',
        [
          id,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            auth = AuthData(
              userId: int.parse("${result[i]['id']}"),
              email: "${result[i]['email']}",
              password: "${result[i]['pass']}",
              name: "${result[i]['name']}",
              phone: "${result[i]['phone']}",
              address: "${result[i]['address']}",
              role: "${result[i]['role']}",
            );
          }
        }
      });
    });

    return auth;
  }

  Future<AuthData?> readLoginUser(String email, String pass) async {
    AuthData? user;

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user WHERE email = ? AND pass = ?',
        [
          email,
          pass,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            user = AuthData(
              userId: int.parse("${result[i]['id']}"),
              name: "${result[i]['name']}",
              phone: "${result[i]['phone']}",
              email: "${result[i]['email']}",
              password: "${result[i]['pass']}",
              address: "${result[i]['address']}",
              role: "${result[i]['role']}",
            );
          }
        }
      });
    });

    return user;
  }

  // UPDATE
  Future<bool> updateUser(AuthData user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawUpdate(
        'UPDATE user SET name = ?, phone = ?, address = ? WHERE id = ?',
        [
          user.name,
          user.phone,
          user.address,
          user.userId,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }
}