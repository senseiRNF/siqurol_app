import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '${GlobalString.assetImagePath}/header_banner.png',
      fit: BoxFit.cover,
    );
  }
}

class ScreenHeader extends StatelessWidget {
  final Function onBackPressed;

  const ScreenHeader({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          '${GlobalString.assetImagePath}/header_banner.png',
          fit: BoxFit.cover,
        ),
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0,),
            child: InkWell(
              onTap: () => onBackPressed(),
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(5.0,),
                child: Icon(
                  Icons.arrow_back,
                  size: 40.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}