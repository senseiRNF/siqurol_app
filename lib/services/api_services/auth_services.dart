import 'package:dio/dio.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/user_model.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/login_model.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';
import 'package:siqurol_app/services/shared_preferences.dart';

class AuthServices {
  Future<bool> writeUser(AuthData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'nama': data.name,
        'no_telp': data.phone,
        'alamat': data.address,
        'email': data.email,
        'pass': data.password,
        'role': data.role,
        'status_user': 'inactive',
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/write-user.php',
          data: formData,
        ).then((postResult) async {
          UserModelAPI createUserData = UserModelAPI.fromJson(postResult.data);

          if(createUserData.status == 1) {
            await SharedPref().writeAuthorization(
              AuthData(
                userId: createUserData.userId,
                email: data.email,
                name: data.name,
                phone: data.phone,
                address: data.address,
                role: data.role,
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

  Future<bool> updateUser(AuthData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'id': data.userId,
        'nama': data.name,
        'no_telp': data.phone,
        'alamat': data.address,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/update-user.php',
          data: formData,
        ).then((postResult) async {
          if(postResult.data['status'] == 1) {
            await SharedPref().writeAuthorization(
              AuthData(
                userId: data.userId,
                name: data.name,
                phone: data.phone,
                address: data.address,
                email: data.email,
                role: data.role,
              ),
            ).then((writeAuth) {
              if(writeAuth) {
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
          LoginModelAPI loginUserModel = LoginModelAPI.fromJson(postResult.data);

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