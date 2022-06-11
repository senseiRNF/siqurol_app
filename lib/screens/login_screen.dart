import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/login_screen_widgets/login_fragment.dart';
import 'package:siqurol_app/widgets/login_screen_widgets/login_screen_header.dart';
import 'package:siqurol_app/widgets/login_screen_widgets/sign_up_fragment.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    '${GlobalString.assetImagePath}/login_header_banner.png',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: LoginScreenHeader(
                    selectedMenu: selectedMenu,
                    onChange: (result) {
                      setState(() {
                        selectedMenu = result;
                      });
                    },
                  ),
                ),
                selectedMenu == 0 ?
                const Expanded(
                  child: LoginFragment(),
                ) :
                const Expanded(
                  child: SignUpFragment(),
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