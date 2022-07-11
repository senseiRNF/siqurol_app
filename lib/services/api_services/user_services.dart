import 'package:dio/dio.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/user_response.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';
import 'package:siqurol_app/services/shared_preferences.dart';

class UserServices {
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
          CreateUserResponseAPI createUserData = CreateUserResponseAPI.fromJson(postResult.data);

          if(createUserData.status == 1) {
            await SharedPref().writeAuthorization(
              AuthData(
                userId: createUserData.userId,
                email: data.email,
                name: data.name,
                phone: data.phone,
                address: data.address,
                role: data.role,
                status: 'inactive',
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
                status: data.status,
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

  Future<List<AuthData>> readUserOnly() async {
    List<AuthData> result = [];

    await InitAPI().clientAdapter().then((dio) async {
      await dio.get(
        '/read-only-user.php',
      ).then((getResult) {
        ReadUserResponseAPI userResponseAPI = ReadUserResponseAPI.fromJson(getResult.data);

        if(userResponseAPI.data != null && userResponseAPI.data!.isNotEmpty) {
          for(int i = 0; i < userResponseAPI.data!.length; i++) {
            result.add(
              AuthData(
                userId: int.parse(userResponseAPI.data![i].id!),
                email: userResponseAPI.data![i].email,
                name: userResponseAPI.data![i].nama,
                phone: userResponseAPI.data![i].noTelp,
                address: userResponseAPI.data![i].alamat,
                status: userResponseAPI.data![i].statusUser,
              ),
            );
          }
        }
      });
    });

    return result;
  }

  Future<bool> updateUserStatus(AuthData data) async {
    bool result = false;

    FormData formData = FormData.fromMap(
      {
        'id': data.userId,
        'status_user': data.status,
      },
    );

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          '/update-user-status.php',
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