import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
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
    final GlobalKey genKey = GlobalKey();

    Future<void> saveCertificate() async {
      var status = await Permission.storage.status;

      if(status.isGranted) {
        RenderRepaintBoundary boundary = genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

        ui.Image image = await boundary.toImage();
        final directory = (await getApplicationDocumentsDirectory()).path;

        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        File imgFile = File('$directory/photo.png');

        imgFile.writeAsBytes(pngBytes);

        var savingResult = await ImageGallerySaver.saveImage(await imgFile.readAsBytes());

        if(savingResult['isSuccess']) {
          GlobalDialog(context: context, message: 'Sertifikat berhasil di unduh').okDialog(() {

          });
        }
      } else {
        await Permission.storage.request().then((permissionResult) async {
          if(permissionResult.isGranted) {
            RenderRepaintBoundary boundary = genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

            ui.Image image = await boundary.toImage();
            final directory = (await getApplicationDocumentsDirectory()).path;

            ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
            Uint8List pngBytes = byteData!.buffer.asUint8List();

            File imgFile = File('$directory/photo.png');

            imgFile.writeAsBytes(pngBytes);

            var savingResult = await ImageGallerySaver.saveImage(await imgFile.readAsBytes());

            if(savingResult['isSuccess']) {
              GlobalDialog(context: context, message: 'Sertifikat berhasil di unduh').okDialog(() {

              });
            }
          } else {
            GlobalDialog(context: context, message: 'Tidak dapat melanjutkan, diperlukan izin untuk mengakses penyimpanan').okDialog(() {

            });
          }
        });
      }
    }

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
              child: RepaintBoundary(
                key: genKey,
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
                                paddingBottom: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 65.0,
                                  child: Image.asset(
                                    '${GlobalString.assetImagePath}/signature_no_bg.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
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
            ),
            GlobalElevatedButton(
              title: 'Unduh',
              onPressed: () {
                saveCertificate();
              },
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}