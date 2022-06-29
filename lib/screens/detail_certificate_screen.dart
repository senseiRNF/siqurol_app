import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class DetailCertificateScreen extends StatelessWidget {
  final String username;

  const DetailCertificateScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        '${GlobalString.assetImagePath}/certificate.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const GlobalText(
                            content: 'SERTIFIKAT',
                            size: 20.0,
                            color: Colors.amber,
                            isBold: true,
                            align: TextAlign.center,
                          ),
                          const GlobalText(
                            content: 'Sertifikat ini dianugerahkan kepada',
                            align: TextAlign.center,
                            size: 12.0,
                            padding: GlobalPaddingClass(
                              paddingBottom: 10.0,
                            ),
                          ),
                          GlobalText(
                            content: username,
                            align: TextAlign.center,
                            size: 16.0,
                            isBold: true,
                            padding: const GlobalPaddingClass(
                              paddingBottom: 10.0,
                            ),
                          ),
                          const GlobalText(
                            content: 'Karena telah berpartisipasi sebagai peserta pada acara:',
                            size: 12.0,
                            align: TextAlign.center,
                          ),
                          const GlobalText(
                            content: '"Pelatihan Pembekalan Penugasan Khusus Tenaga Kesehatan"',
                            align: TextAlign.center,
                            size: 12.0,
                            padding: GlobalPaddingClass(
                              paddingBottom: 10.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              GlobalText(
                                content: '________________',
                                align: TextAlign.center,
                                size: 12.0,
                                padding: GlobalPaddingClass(
                                  paddingTop: 50.0,
                                ),
                              ),
                              GlobalText(
                                content: '________________',
                                align: TextAlign.center,
                                size: 12.0,
                                padding: GlobalPaddingClass(
                                  paddingTop: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GlobalElevatedButton(
              title: 'Unduh',
              onPressed: () {

              },
              padding: const GlobalPaddingClass(
                paddingBottom: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}