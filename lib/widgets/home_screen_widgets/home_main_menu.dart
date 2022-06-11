import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/main_menu.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class HomeMainMenu extends StatelessWidget {
  final MainMenuClasses mainMenu;

  const HomeMainMenu({
    Key? key,
    required this.mainMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
      ),
      child: InkWell(
        onTap: () => mainMenu.onPressed(),
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0,)
        ),
        child: GlobalPadding(
          paddingClass: const GlobalPaddingClass(
            paddingLeft: 10.0,
            paddingTop: 5.0,
            paddingRight: 10.0,
            paddingBottom: 5.0,
          ),
          content: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0,),
                  child: Image.asset(
                    mainMenu.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GlobalText(
                content: mainMenu.title,
                size: 16.0,
                color: GlobalColor.defaultBlue,
                isBold: true,
                align: TextAlign.center,
                padding: const GlobalPaddingClass(
                  paddingBottom: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}