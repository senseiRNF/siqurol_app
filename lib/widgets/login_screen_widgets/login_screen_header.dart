import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              '${GlobalString.assetImagePath}/icon_kemenkes_ext.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 35.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(0),
                      child: GlobalText(
                        content: 'Masuk',
                        size: 20.0,
                        color: selectedMenu == 0 ? GlobalColor.defaultGreen : GlobalColor.defaultWhite,
                        align: TextAlign.center,
                        isBold: true,
                        padding: const GlobalPaddingClass(
                          paddingTop: 10.0,
                          paddingBottom: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(1),
                      child: GlobalText(
                        content: 'Daftar',
                        size: 20.0,
                        color: selectedMenu != 0 ? GlobalColor.defaultGreen : GlobalColor.defaultWhite,
                        align: TextAlign.center,
                        isBold: true,
                        padding: const GlobalPaddingClass(
                          paddingTop: 10.0,
                          paddingBottom: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        /**/
      ],
    );
  }
}