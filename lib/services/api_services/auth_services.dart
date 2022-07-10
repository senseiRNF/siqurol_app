import 'package:dio/dio.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/user_response.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';
import 'package:siqurol_app/services/shared_preferences.dart';

class AuthServices {
  Future<bool> loginUser(AuthData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'email': data.email,
        'pass': data.password,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/read-login-user.php',
          data: formData,
        ).then((postResult) async {
          ReadUserResponseAPI loginUserModel = ReadUserResponseAPI.fromJson(postResult.data);

          if(loginUserModel.status == 1) {
            await SharedPref().writeAuthorization(
              AuthData(
                userId: int.parse(loginUserModel.data![0].id!),
                email: loginUserModel.data![0].email,
                name: loginUserModel.data![0].nama,
                phone: loginUserModel.data![0].noTelp,
                address: loginUserModel.data![0].alamat,
                role: loginUserModel.data![0].role,
                status: loginUserModel.data![0].statusUser,
              ),
            ).then((authResult) {
              if(authResult) {
                result = true;
              }
            });
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}