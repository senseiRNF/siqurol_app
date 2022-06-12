import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';

class LoginScreenHeader extends StatelessWidget {
  final int selectedMenu;
  final Function onChange;

  const LoginScreenHeader({
    Key? key,
    required this.selectedMenu,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlobalPadding(
          paddingClass: const GlobalPaddingClass(
            paddingLeft: 10.0,
            paddingTop: 20.0,
            paddingRight: 10.0,
            paddingBottom: 30.0,
          ),
          content: Image.asset(
            '${GlobalString.assetImagePath}/icon_kemenkes_ext.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: GlobalElevatedButton(
                  onPressed: () => onChange(0),
                  title: 'Masuk',
                  btnColor: GlobalColor.defaultGreen,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: GlobalElevatedButton(
                  onPressed: () => onChange(1),
                  title: 'Daftar',
                  btnColor: GlobalColor.defaultGreen,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}