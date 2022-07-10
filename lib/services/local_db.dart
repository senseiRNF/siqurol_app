import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
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
  Future<bool> writeTrainingParticipant(int trainingId, AuthData user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO training_participant (training_id, user_id, certificate_status) VALUES (?, ?, ?)',
        [
          trainingId,
          user.userId,
          'detained',
        ],
      ).then((id) {
        result = true;
      });
    });

    return result;
  }

  // READ
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

  Future<List<TrainingParticipantData>> readTrainingParticipant(int trainingId) async {
    List<TrainingParticipantData> participant = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT u.id, u.name, u.email, tp.certificate_status FROM user u, training_participant tp WHERE tp.training_id = ? AND tp.user_id = u.id',
        [
          trainingId,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            participant.add(
              TrainingParticipantData(
                auth: AuthData(
                  userId: int.parse("${result[i]['id']}"),
                  name: "${result[i]['name']}",
                  email: "${result[i]['email']}",
                ),
                isChecked: result[i]['certificate_status'] == 'received' ? true : false,
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
  Future<bool> updateCertificateParticipant(String status, int trainingId, AuthData user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'UPDATE training_participant SET certificate_status = ? WHERE training_id = ? AND user_id = ?',
        [
          status,
          trainingId,
          user.userId,
        ],
      ).then((id) {
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