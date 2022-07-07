import 'package:dio/dio.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/response_api/create_user_data.dart';
import 'package:siqurol_app/services/api_services/init_api.dart';
import 'package:siqurol_app/services/shared_preferences.dart';

class AuthServices {
  Future<bool> createUser(AuthData data) async {
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
          '/create-user.php',
          data: formData,
        ).then((postResult) async {
          CreateUserData createUserData = CreateUserData.fromJson(postResult.data);

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
      } on DioError catch(e) {
        print(e);
      }
    });

    return result;
  }
}