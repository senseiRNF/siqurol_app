import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/screens/detail_certificate_screen.dart';
import 'package:siqurol_app/services/api_services/training_services.dart';
import 'package:siqurol_app/services/shared_preferences.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  List<TrainingData> certificateList = [];

  String? username;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((auth) async {
      if(auth != null && auth.userId != null) {
        setState(() {
          username = auth.name;
        });

        await TrainingServices().readTrainingByUser(auth.userId!).then((result) async {
          setState(() {
            certificateList = result;
          });
        });
      }
    });
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
              ListView.builder(
                itemCount: certificateList.length,
                itemBuilder: (BuildContext listContext, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        GlobalRoute(context: context).moveTo(DetailCertificateScreen(username: username!,), (callback) {

                        });
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0,),
                      ),
                      child: GlobalPadding(
                        paddingClass: const GlobalPaddingClass(
                          paddingLeft: 10.0,
                          paddingTop: 10.0,
                          paddingRight: 10.0,
                          paddingBottom: 10.0,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GlobalText(
                              content: "Tanggal: ${certificateList[index].date != null ? DateFormat('dd/MM/yyyy').format(certificateList[index].date!) : 'Tanggal Tak Diketahui'}",
                              color: GlobalColor.defaultBlue,
                              size: 18.0,
                              isBold: true,
                            ),
                            GlobalText(
                              content: "Jam: ${certificateList[index].hour != null ? DateFormat('HH:mm').format(DateTime(certificateList[index].date!.year, certificateList[index].date!.month, certificateList[index].date!.day, certificateList[index].hour!.hour, certificateList[index].hour!.minute)) : 'Waktu Tak Diketahui'}",
                              color: GlobalColor.defaultBlue,
                              size: 18.0,
                              isBold: true,
                              padding: const GlobalPaddingClass(
                                paddingBottom: 10.0,
                              ),
                            ),
                            GlobalText(
                              content: "Pembicara: ${certificateList[index].speaker ?? 'Pembicara Tak Diketahui'}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) :
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