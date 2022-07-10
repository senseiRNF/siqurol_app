import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/home_screen.dart';
import 'package:siqurol_app/services/api_services/user_services.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';

class SignUpFragment extends StatelessWidget {
  final double topPadding;
  final TextEditingController nameTEC;
  final TextEditingController phoneTEC;
  final TextEditingController addressTEC;
  final TextEditingController emailTEC;
  final TextEditingController passTEC;
  final TextEditingController confPassTEC;

  const SignUpFragment({
    Key? key,
    required this.topPadding,
    required this.nameTEC,
    required this.phoneTEC,
    required this.addressTEC,
    required this.emailTEC,
    required this.passTEC,
    required this.confPassTEC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height - topPadding,
      decoration: const BoxDecoration(
        color: Colors.transparent,
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
              title: 'Konfirmasi Password',
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
            GlobalTextfield(
              controller: addressTEC,
              title: 'Alamat',
              padding: const GlobalPaddingClass(
                paddingLeft: 50.0,
                paddingRight: 50.0,
              ),
            ),
            GlobalElevatedButton(
              onPressed: () async {
                if(passTEC.text == confPassTEC.text && nameTEC.text != '' && emailTEC.text != '' && passTEC.text != '' && phoneTEC.text != '' && addressTEC.text != '') {
                  GlobalDialog(context: context, message: 'Mendaftarkan data, pastikan data Anda sudah terisi dan benar, Lanjutkan?').optionDialog(() async {
                    await UserServices().writeUser(
                      AuthData(
                        name: nameTEC.text,
                        email: emailTEC.text,
                        password: passTEC.text,
                        phone: phoneTEC.text,
                        address: addressTEC.text,
                        role: 'user',
                      ),
                    ).then((result) async {
                      if(result) {
                        GlobalRoute(context: context).replaceWith(
                          const HomeScreen(),
                        );
                      } else {
                        GlobalDialog(context: context, message: 'Gagal mendaftar, mohon periksa seluruh data Anda dan coba lagi').okDialog(() {

                        });
                      }
                    });
                  }, () {

                  });
                } else {
                  GlobalDialog(context: context, message: 'Gagal mendaftar, mohon periksa seluruh data Anda dan coba lagi').okDialog(() {

                  });
                }
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