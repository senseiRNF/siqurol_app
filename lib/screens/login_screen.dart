import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
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

  TextEditingController loginEmailTEC = TextEditingController();
  TextEditingController loginPassTEC = TextEditingController();

  TextEditingController signUpNameTEC = TextEditingController();
  TextEditingController signUpPhoneTEC = TextEditingController();
  TextEditingController signUpAddressTEC = TextEditingController();
  TextEditingController signUpEmailTEC = TextEditingController();
  TextEditingController signUpPassTEC = TextEditingController();
  TextEditingController signUpConfPassTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Builder(
              builder: (BuildContext bottomContext) {
                return LoginScreenHeader(
                  selectedMenu: selectedMenu,
                  onChange: (result) {
                    setState(() {
                      selectedMenu = result;
                    });

                    Scaffold.of(bottomContext).showBottomSheet((BuildContext bottomSheetContext) {
                        return selectedMenu == 0 ?
                        LoginFragment(
                          topPadding: MediaQuery.of(context).viewPadding.top,
                          emailTEC: loginEmailTEC,
                          passTEC: loginPassTEC,
                        ) :
                        SignUpFragment(
                          topPadding: MediaQuery.of(context).viewPadding.top,
                          nameTEC: signUpNameTEC,
                          emailTEC: signUpEmailTEC,
                          phoneTEC: signUpPhoneTEC,
                          addressTEC: signUpAddressTEC,
                          passTEC: signUpPassTEC,
                          confPassTEC: signUpConfPassTEC,
                        );
                      },
                      backgroundColor: GlobalColor.defaultWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0,),
                          topRight: Radius.circular(30.0,),
                        ),
                      ),
                    );
                  },
                );
              },
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