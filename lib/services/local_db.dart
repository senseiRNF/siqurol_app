import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
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

  Future<bool> writeTraining(TrainingData schedule) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO training (date, hour, participant, speaker) VALUES (?, ?, ?, ?)',
        [
          DateFormat('yyyy-MM-dd').format(schedule.date!),
          DateFormat('HH:mm').format(DateTime(schedule.date!.year, schedule.date!.month, schedule.date!.day, schedule.hour!.hour, schedule.hour!.minute)),
          0,
          schedule.speaker,
        ],
      ).then((id) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> writeTrainingParticipant(int trainingId, AuthData user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO training_participant (training_id, user_id, certificate_status) VALUES (?, ?, ?)',
        [
          trainingId,
          user.userId,
          'Waiting',
        ],
      ).then((id) {
        result = true;
      });
    });

    return result;
  }

  // READ
  Future<List<AuthData>> readAllUser() async {
    List<AuthData> authList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            authList.add(
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

    return authList;
  }

  Future<List<TrainingData>> readAllTraining() async {
    List<TrainingData> trainingList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM training',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            trainingList.add(
              TrainingData(
                scheduleId: int.parse("${result[i]['id']}"),
                date: result[i]['date'] != null && result[i]['date'] != '' ? DateTime.parse("${result[i]['date']}") : null,
                hour: TimeOfDay.fromDateTime(DateTime.parse('2022-01-01 ${result[i]['hour']}')),
                speaker: "${result[i]['speaker']}",
                numberOfParticipant: int.parse("${result[i]['participant']}"),
              ),
            );
          }
        }
      });
    });

    return trainingList;
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

  Future<List<AuthData>> readTrainingParticipant(int trainingId) async {
    List<AuthData> participant = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT u.id, u.name, u.email FROM user u, training_participant tp WHERE tp.training_id = ? AND tp.user_id = u.id',
        [
          trainingId,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            participant.add(
              AuthData(
                userId: int.parse("${result[i]['id']}"),
                name: "${result[i]['name']}",
                email: "${result[i]['email']}",
              ),
            );
          }
        }
      });
    });

    return participant;
  }

  Future<List<TrainingData>> readTrainingByUser(int userId) async {
    List<TrainingData> trainingList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT t.* FROM training t, training_participant tp WHERE tp.user_id = ? AND tp.training_id = t.id',
        [
          userId,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            trainingList.add(
              TrainingData(
                scheduleId: int.parse("${result[i]['id']}"),
                date: result[i]['date'] != null && result[i]['date'] != '' ? DateTime.parse("${result[i]['date']}") : null,
                hour: TimeOfDay.fromDateTime(DateTime.parse('2022-01-01 ${result[i]['hour']}')),
                speaker: "${result[i]['speaker']}",
                numberOfParticipant: int.parse("${result[i]['participant']}"),
              ),
            );
          }
        }
      });
    });

    return trainingList;
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

  Future<bool> updateTraining(TrainingData training) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawUpdate(
        'UPDATE training SET date = ?, hour = ?, speaker = ? WHERE id = ?',
        [
          DateFormat('yyyy-MM-dd').format(training.date!),
          DateFormat('HH:mm').format(DateTime(training.date!.year, training.date!.month, training.date!.day, training.hour!.hour, training.hour!.minute)),
          training.speaker,
          training.scheduleId,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  // DELETE
  Future<bool> deleteTrainingParticipant(int trainingId, AuthData user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'DELETE FROM training_participant WHERE training_id = ? AND user_id = ?',
        [
          trainingId,
          user.userId,
        ],
      ).then((id) {
        result = true;
      });
    });

    return result;
  }
}