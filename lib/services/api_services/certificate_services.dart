import 'package:dio/dio.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';

class CertificateServices {
  Future<bool> updateCertificateParticipant(String status, int trainingId, AuthData user) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id_jadwal': trainingId,
      'id_user': user.userId,
      'status_sertifikat': status,
    });

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/update-certificate-participant.php',
          data: formData,
        ).then((postResult) {
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