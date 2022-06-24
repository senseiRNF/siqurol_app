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
          auth.userId.toString(),
          auth.email ?? 'Tak Diketahui',
          auth.password ?? 'Tak Diketahui',
          auth.name ?? 'Tak Diketahui',
          auth.phone ?? 'Tak Diketahui',
          auth.address ?? 'Tak Diketahui',
          auth.role ?? 'Tak Diketahui',
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
          userId: int.parse(stringList![0]),
          email: stringList![1],
          password: stringList![2],
          name: stringList![3],
          phone: stringList![4],
          address: stringList![5],
          role: stringList![6],
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