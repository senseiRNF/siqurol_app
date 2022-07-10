import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/training_model.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';

class TrainingServices {
  Future<bool> createTraining(TrainingData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'tanggal': DateFormat('yyyy-MM-dd').format(data.date!),
        'jam': DateFormat('HH:mm').format(DateTime(data.date!.year, data.date!.month, data.date!.day, data.hour!.hour, data.hour!.minute)),
        'pembicara': data.speaker,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/write-training.php',
          data: formData,
        ).then((postResult) async {
          if(postResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> updateTraining(TrainingData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'id': data.scheduleId,
        'tanggal': DateFormat('yyyy-MM-dd').format(data.date!),
        'jam': DateFormat('HH:mm').format(DateTime(data.date!.year, data.date!.month, data.date!.day, data.hour!.hour, data.hour!.minute)),
        'pembicara': data.speaker,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/update-training.php',
          data: formData,
        ).then((postResult) async {
          if(postResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<List<TrainingData>> readAllTraining() async {
    List<TrainingData> result = [];

    await InitAPI().clientAdapter().then((dio) async {
      await dio.get(
        '/read-all-training.php',
      ).then((getResult) {
        TrainingResponseAPI trainingModel = TrainingResponseAPI.fromJson(getResult.data);

        if(trainingModel.data != null && trainingModel.data!.isNotEmpty) {
          for(int i = 0; i < trainingModel.data!.length; i++) {
            result.add(
              TrainingData(
                scheduleId: int.parse(trainingModel.data![i].id!),
                date: DateTime.parse(trainingModel.data![i].tanggal!),
                hour: TimeOfDay.fromDateTime(DateTime.parse('${trainingModel.data![i].tanggal!} ${trainingModel.data![i].jam}')),
                speaker: trainingModel.data![i].pembicara,
              ),
            );
          }
        }
      });
    });

    return result;
  }

  Future<List<TrainingData>> readTrainingByUser(int userId) async {
    List<TrainingData> trainingList = [];

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-training-by-user.php',
          queryParameters: {
            'id': userId,
          },
        ).then((getResult) {
          TrainingResponseAPI trainingResponseAPI = TrainingResponseAPI.fromJson(getResult.data);

          if(trainingResponseAPI.data != null && trainingResponseAPI.data!.isNotEmpty) {
            for(int i = 0; i < trainingResponseAPI.data!.length; i++) {
              trainingList.add(
                TrainingData(
                  scheduleId: int.parse(trainingResponseAPI.data![i].id!),
                  date: trainingResponseAPI.data![i].tanggal != null && trainingResponseAPI.data![i].tanggal != '' ? DateTime.parse("${trainingResponseAPI.data![i].tanggal}") : null,
                  hour: TimeOfDay.fromDateTime(DateTime.parse('2022-01-01 ${trainingResponseAPI.data![i].jam}')),
                  speaker: trainingResponseAPI.data![i].pembicara,
                ),
              );
            }
          }
        });
      } on DioError catch(_) {

      }
    });

    return trainingList;
  }

  Future<bool> createTrainingParticipant(int trainingId, AuthData user) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'id_jadwal': trainingId,
        'id_user': user.userId,
        'status_sertifikat': 'detained',
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/write-training-participant.php',
          data: formData,
        ).then((postResult) async {
          if(postResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<List<TrainingParticipantData>> readTrainingParticipant(int trainingId) async {
    List<TrainingParticipantData> result = [];

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          '/read-training-participant.php',
          queryParameters: {
            'id': trainingId,
          },
        ).then((getResult) {
          TrainingParticipantResponseAPI participantResponseAPI = TrainingParticipantResponseAPI.fromJson(getResult.data);

          if (participantResponseAPI.data != null &&
              participantResponseAPI.data!.isNotEmpty) {
            for (int i = 0; i < participantResponseAPI.data!.length; i++) {
              result.add(
                TrainingParticipantData(
                  auth: AuthData(
                    userId: int.parse(participantResponseAPI.data![i].id!),
                    name: participantResponseAPI.data![i].nama,
                    email: participantResponseAPI.data![i].email,
                  ),
                  isChecked: participantResponseAPI.data![i].statusSertifikat ==
                      'received' ? true : false,
                ),
              );
            }
          }
        });
      } on DioError catch (_) {

      }
    });

    return result;
  }

  Future<bool> deleteTrainingParticipant(int trainingId, AuthData user) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'id_jadwal': trainingId,
        'id_user': user.userId,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/delete-training-participant.php',
          data: formData,
        ).then((postResult) async {
          if(postResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}