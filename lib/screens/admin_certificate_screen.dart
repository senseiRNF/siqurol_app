import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminCertificateScreen extends StatefulWidget {
  const AdminCertificateScreen({Key? key}) : super(key: key);

  @override
  State<AdminCertificateScreen> createState() => _AdminCertificateScreenState();
}

class _AdminCertificateScreenState extends State<AdminCertificateScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GlobalHeader(),
            GlobalText(
              content: 'Sertifikat',
              size: 26.0,
              color: GlobalColor.defaultBlue,
              isBold: true,
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingTop: 10.0,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      '${GlobalString.assetImagePath}/certificate_icon.png',
                      height: 80.0,
                    ),
                    const GlobalText(
                      content: 'Unggah Model Sertifikat',
                      size: 20.0,
                      isBold: true,
                      align: TextAlign.center,
                      padding: GlobalPaddingClass(
                        paddingTop: 20.0,
                        paddingBottom: 20.0,
                      ),
                    ),
                    const Icon(
                      Icons.upload_file,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}