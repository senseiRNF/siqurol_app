import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/participant_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({Key? key}) : super(key: key);

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
  List<ParticipantData> participantList = [];

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
              content: 'Data Peserta',
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
                child: participantList.isNotEmpty ?
                ListView() :
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GlobalText(
                      content: 'Belum ada data untuk ditampilkan',
                      size: 18.0,
                      isBold: true,
                      color: GlobalColor.defaultBlue,
                      align: TextAlign.center,
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