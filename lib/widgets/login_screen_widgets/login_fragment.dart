import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/home_screen.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';

class LoginFragment extends StatelessWidget {
  const LoginFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passTEC = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0,),
          topRight: Radius.circular(30.0,),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0,),
            child: Image.asset(
              '${GlobalString.assetImagePath}/login_banner.png',
              fit: BoxFit.contain,
            ),
          ),
          GlobalTextfield(
            controller: emailTEC,
            title: 'Email',
            inputType: TextInputType.emailAddress,
            padding: const GlobalPaddingClass(
              paddingLeft: 50.0,
              paddingRight: 50.0,
            ),
          ),
          GlobalPasswordField(
            controller: passTEC,
            title: 'Password',
            padding: const GlobalPaddingClass(
              paddingLeft: 50.0,
              paddingRight: 50.0,
            ),
          ),
          GlobalTextButton(
            onPressed: () {

            },
            title: 'Lupa Password?',
            titleColor: GlobalColor.defaultRed,
            padding: const GlobalPaddingClass(
              paddingLeft: 40.0,
              paddingTop: 10.0,
              paddingRight: 40.0,
              paddingBottom: 10.0,
            ),
          ),
          GlobalElevatedButton(
            onPressed: () {
              bool isAdmin = emailTEC.text == 'admin' ? true : false;

              GlobalRoute(context: context).replaceWith(
                HomeScreen(
                  isAdmin: isAdmin,
                ),
              );
            },
            title: 'Masuk',
            titleSize: 18.0,
            btnColor: GlobalColor.defaultBlue,
            padding: const GlobalPaddingClass(
              paddingLeft: 40.0,
              paddingTop: 10.0,
              paddingRight: 40.0,
              paddingBottom: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}