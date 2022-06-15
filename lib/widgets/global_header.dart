import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';

class GlobalHeader extends StatelessWidget {
  final bool? isMain;

  const GlobalHeader({
    Key? key,
    this.isMain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isMain != null && isMain!) {
      return Image.asset(
        '${GlobalString.assetImagePath}/header_banner.png',
        fit: BoxFit.cover,
      );
    } else {
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
                onTap: () {
                  GlobalRoute(context: context).back(null);
                },
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
}