import 'package:shared_preferences/shared_preferences.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';

class SharedPref {
  Future<SharedPreferences> init() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref;
  }

  Future<bool> writeAuthorization(AuthData auth) async {
    bool result = false;

    await init().then((sharedPrefs) async {
      await sharedPrefs.setStringList(
        'AUTH',
        [
          auth.userId,
          auth.email,
          auth.name,
          auth.phone,
          auth.address,
          auth.role,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<AuthData?> readAuthorization() async {
    AuthData? result;
    List<String>? stringList;

    await init().then((sharedPrefs) async {
      stringList = sharedPrefs.getStringList('AUTH');

      if(stringList != null && stringList!.isNotEmpty) {
        result = AuthData(
          userId: stringList![0],
          email: stringList![1],
          name: stringList![2],
          phone: stringList![3],
          address: stringList![4],
          role: stringList![5],
        );
      }
    });

    return result;
  }

  Future<bool> deleteAuthorization() async {
    bool result = false;

    await init().then((sharedPrefs) async {
      await sharedPrefs.remove('AUTH').then((_) {
        result = true;
      });
    });

    return result;
  }
}