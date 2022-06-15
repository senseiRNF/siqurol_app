import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/home_screen.dart';
import 'package:siqurol_app/services/shared_preferences.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';

class SignUpFragment extends StatelessWidget {
  final double topPadding;

  const SignUpFragment({
    Key? key,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passTEC = TextEditingController();
    TextEditingController confPassTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController addressTEC = TextEditingController();

    return Container(
      height: MediaQuery.of(context).size.height - topPadding,
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0,),
          topRight: Radius.circular(30.0,),
        ),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0,),
              child: Image.asset(
                '${GlobalString.assetImagePath}/register_banner.png',
                fit: BoxFit.contain,
              ),
            ),
            GlobalTextfield(
              controller: nameTEC,
              title: 'Nama',
              padding: const GlobalPaddingClass(
                paddingLeft: 50.0,
                paddingRight: 50.0,
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
            GlobalPasswordField(
              controller: confPassTEC,
              title: 'Confirm Password',
              padding: const GlobalPaddingClass(
                paddingLeft: 50.0,
                paddingRight: 50.0,
              ),
            ),
            GlobalTextfield(
              controller: phoneTEC,
              title: 'No. Telp',
              inputType: TextInputType.phone,
              padding: const GlobalPaddingClass(
                paddingLeft: 50.0,
                paddingRight: 50.0,
              ),
            ),
            GlobalTextFormField(
              controller: addressTEC,
              title: 'Alamat',
              padding: const GlobalPaddingClass(
                paddingLeft: 50.0,
                paddingRight: 50.0,
              ),
            ),
            GlobalElevatedButton(
              onPressed: () async {
                await SharedPref().writeAuthorization(
                  AuthData(
                    userId: '1',
                    email: 'user.example.com',
                    username: 'User',
                    phone: '0123456789',
                    address: 'Unknown Address',
                    role: 'user',
                  ),
                );

                GlobalRoute(context: context).replaceWith(
                  const HomeScreen(
                    isAdmin: false,
                  ),
                );
              },
              title: 'Daftar',
              titleSize: 18.0,
              btnColor: GlobalColor.defaultBlue,
              padding: const GlobalPaddingClass(
                paddingLeft: 40.0,
                paddingTop: 20.0,
                paddingRight: 40.0,
                paddingBottom: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}