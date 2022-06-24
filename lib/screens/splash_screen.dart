import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/home_screen.dart';
import 'package:siqurol_app/screens/login_screen.dart';
import 'package:siqurol_app/services/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((AuthData? auth) {
      if(auth != null) {
        Future.delayed(const Duration(seconds: 2), () {
          GlobalRoute(context: context).replaceWith(const HomeScreen());
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          GlobalRoute(context: context).replaceWith(const LoginScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    '${GlobalString.assetImagePath}/splash_background.png',
                  ),
                  opacity: 0.8,
                  fit: BoxFit.fill,
                ),
              ),
              padding: const EdgeInsets.all(50.0,),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0,),
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}