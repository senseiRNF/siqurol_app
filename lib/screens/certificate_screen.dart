import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/certificate_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  List<CertificateData> certificateList = [];

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
                paddingBottom: 10.0,
              ),
            ),
            Expanded(
              child: certificateList.isNotEmpty ?
              ListView() :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlobalText(
                    content: 'Belum ada sertifikat untuk ditampilkan',
                    size: 18.0,
                    isBold: true,
                    color: GlobalColor.defaultBlue,
                    align: TextAlign.center,
                  ),
                ],
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