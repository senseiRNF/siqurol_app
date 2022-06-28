import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class DetailScheduleScreen extends StatelessWidget {
  final TrainingData trainingData;
  final String username;

  const DetailScheduleScreen({
    Key? key,
    required this.trainingData,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GlobalHeader(),
            Expanded(
              child: ListView(
                children: [
                  Image.asset(
                    '${GlobalString.assetImagePath}/header_mail.jpeg',
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    color: GlobalColor.defaultWhite,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GlobalText(
                          content: 'Yth. Saudara/i $username',
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                            paddingBottom: 20.0,
                          ),
                        ),
                        const GlobalText(
                          content: 'Terima kasih telah mendaftarkan diri Anda pada acara:',
                          padding: GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        const GlobalText(
                          content: '"Pelatihan Pembekalan Penugasan Khusus Tenaga Kesehatan"',
                          isBold: true,
                          padding: GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                            paddingBottom: 20.0,
                          ),
                        ),
                        const GlobalText(
                          content: 'Berikut ini merupakan keterangan jadwal kegiatan Anda:',
                          padding: GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                            paddingBottom: 20.0,
                          ),
                        ),
                        GlobalText(
                          content: 'Tanggal: ${DateFormat('dd/MM/yyyy').format(trainingData.date!)}',
                          size: 16.0,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 40.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        GlobalText(
                          content: 'Jam: ${DateFormat('HH:mm').format(DateTime(trainingData.date!.year, trainingData.date!.month, trainingData.date!.day, trainingData.hour!.hour, trainingData.hour!.minute))} WIB',
                          size: 16.0,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 40.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        GlobalText(
                          content: 'Pembicara: ${trainingData.speaker!}',
                          size: 16.0,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 40.0,
                            paddingRight: 20.0,
                            paddingBottom: 20.0,
                          ),
                        ),
                        const GlobalText(
                          content: 'Atas perhatiannya, kami mengucapkan terima kasih.',
                          padding: GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                            paddingBottom: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    '${GlobalString.assetImagePath}/signature_mail.jpeg',
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}