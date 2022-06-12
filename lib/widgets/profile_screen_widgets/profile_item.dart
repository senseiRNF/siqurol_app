import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class ProfileItem extends StatelessWidget {
  final String leadTitle;
  final String content;

  const ProfileItem({
    Key? key,
    required this.leadTitle,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GlobalText(
            content: leadTitle,
            size: 16.0,
            color: GlobalColor.defaultBlue,
            isBold: true,
          ),
        ),
        Expanded(
          flex: 6,
          child: GlobalText(
            content: ': $content',
            size: 16.0,
            color: GlobalColor.defaultBlue,
          ),
        ),
      ],
    );
  }
}