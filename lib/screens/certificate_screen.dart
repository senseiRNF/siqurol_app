import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/certificate_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

// User Form Screen ------------------------------------------------------------
class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {

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
              child: Image.asset(
                '${GlobalString.assetImagePath}/certificate_icon.png'
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

// Admin Participant Screen ----------------------------------------------------
class ParticipantCertificateScreen extends StatefulWidget {
  const ParticipantCertificateScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantCertificateScreen> createState() => _ParticipantCertificateScreenState();
}

class _ParticipantCertificateScreenState extends State<ParticipantCertificateScreen> {
  List<CertificateData> certificateDataList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      certificateDataList = [
        CertificateData(
          participantName: 'Ravie Hidayat',
          certificateUrl: 'https://abcd.com',
        ),
        CertificateData(
          participantName: 'Gerit Linggar',
          certificateUrl: 'https://efgh.com',
        ),
        CertificateData(
          participantName: 'Fahmi Shiddiq',
          certificateUrl: 'https://ijkl.com',
        ),
        CertificateData(
          participantName: 'Ahmad Sofyan',
          certificateUrl: 'https://mnop.com',
        ),
      ];
    });
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: certificateDataList.isNotEmpty ?
                ListView.builder(
                  itemCount: certificateDataList.length,
                  itemBuilder: (BuildContext workshopListContext, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0,),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0,),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GlobalText(
                                      content: certificateDataList[index].participantName,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalText(
                                      content: certificateDataList[index].certificateUrl,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GlobalTextButton(
                          onPressed: () {

                          },
                          title: 'Edit',
                          titleColor: GlobalColor.defaultBlue,
                        ),
                      ],
                    );
                  },
                ) :
                Center(
                  child: GlobalText(
                    content: 'Daftar Tidak Tersedia...',
                    size: 26.0,
                    color: GlobalColor.defaultBlue,
                  ),
                ),
              ),
            ),
            certificateDataList.isNotEmpty ?
            GlobalElevatedButton(
              onPressed: () {

              },
              title: 'Tambah Data',
              padding: const GlobalPaddingClass(
                paddingTop: 20.0,
                paddingBottom: 20.0,
              ),
            ) :
            const Material(),
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