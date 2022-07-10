import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/training_model.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';

class TrainingServices {
  // Training
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
        TrainingModelAPI trainingModel = TrainingModelAPI.fromJson(getResult.data);

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

  // Training Participant
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
          '/write-training_participant.php',
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

  /*Future<List<TrainingParticipantData>> readTrainingParticipant(int trainingId) async {
    List<TrainingParticipantData> result = [];

    await InitAPI().clientAdapter().then((dio) async {
      await dio.get(
        '/read-training-participant.php',
      ).then((getResult) {
        TrainingModelAPI trainingModel = TrainingModelAPI.fromJson(getResult.data);

        if(trainingModel.data != null && trainingModel.data!.isNotEmpty) {
          for(int i = 0; i < trainingModel.data!.length; i++) {
            result.add(
              TrainingParticipantData(
                auth: AuthData(
                  userId: int.parse(trainingModel.data![i].id!),
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

    return result;
  }*/
}