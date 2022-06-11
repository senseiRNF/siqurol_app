import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class SignUpFragment extends StatelessWidget {
  const SignUpFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passTEC = TextEditingController();
    TextEditingController confPassTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController addressTEC = TextEditingController();

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
            onPressed: () {
              log(emailTEC.text);
              log(passTEC.text);
            },
            title: 'Daftar',
            titleSize: 18.0,
            btnColor: GlobalColor.defaultBlue,
            padding: const GlobalPaddingClass(
              paddingLeft: 40.0,
              paddingTop: 20.0,
              paddingRight: 40.0,
              paddingBottom: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}