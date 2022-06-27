import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/main_menu_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class HomeMainMenu extends StatelessWidget {
  final MainMenuData mainMenu;

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
                  child: mainMenu.imagePath != 'help icon' ?
                  Image.asset(
                    mainMenu.imagePath,
                    fit: BoxFit.contain,
                  ) :
                  const Icon(
                    Icons.help_outline,
                    size: 80.0,
                    color: Colors.lightBlue,
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