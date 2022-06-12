import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/certificate_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  CertificateData? certificateData;

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
            ScreenHeader(
              onBackPressed: () {
                GlobalRoute(context: context).back(null);
              },
            ),
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
              child: certificateData != null ?
              ListView() :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        '${GlobalString.assetImagePath}/certificate_icon.png',
                        height: 80.0,
                      ),
                      const GlobalText(
                        content: 'Sertifikat Tidak Ditemukan...',
                        size: 20.0,
                        isBold: true,
                        align: TextAlign.center,
                        padding: GlobalPaddingClass(
                          paddingTop: 20.0,
                        ),
                      ),
                      const GlobalText(
                        content: 'Usap kebawah untuk memperbaharui data',
                        size: 16.0,
                        align: TextAlign.center,
                        padding: GlobalPaddingClass(
                          paddingBottom: 20.0,
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: ListView(

                    ),
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