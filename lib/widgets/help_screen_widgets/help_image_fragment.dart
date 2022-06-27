import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';

class HelpImageFragment extends StatelessWidget {
  const HelpImageFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PhotoView(
          imageProvider: AssetImage(
            '${GlobalString.assetImagePath}/help_instructions.png',
          ),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * 0.8,
        ),
      ),
    );
  }
}