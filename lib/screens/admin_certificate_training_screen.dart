import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/local_db.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class AdminCertificateTrainingScreen extends StatefulWidget {
  final TrainingData trainingData;

  const AdminCertificateTrainingScreen({
    Key? key,
    required this.trainingData,
  }) : super(key: key);

  @override
  State<AdminCertificateTrainingScreen> createState() => _AdminCertificateTrainingScreenState();
}

class _AdminCertificateTrainingScreenState extends State<AdminCertificateTrainingScreen> {
  List<AuthData> participantList = [];
  List<bool> isChecked = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    setState(() {
      isChecked = [];
    });

    await LocalDB().readOnlyUserRole().then((participant) {
      setState(() {
        participantList = participant;

        for(int i = 0; i < participantList.length; i++) {
          isChecked.add(false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GlobalHeader(),
            GlobalText(
              content: 'Daftar Peserta Kegiatan',
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
              child: participantList.isNotEmpty ?
              ListView.builder(
                itemCount: participantList.length,
                itemBuilder: (BuildContext scheduleContext, int index) {
                  return Card(
                    child: GlobalPadding(
                      paddingClass: const GlobalPaddingClass(
                        paddingLeft: 10.0,
                        paddingTop: 10.0,
                        paddingRight: 10.0,
                        paddingBottom: 10.0,
                      ),
                      content: CheckboxListTile(
                        onChanged: (checked) {
                          setState(() {
                            isChecked[index] = !isChecked[index];
                          });
                        },
                        value: isChecked[index],
                        title: GlobalText(
                          content: participantList[index].name ?? 'Nama Tak Diketahui',
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
                    content: 'Belum ada data untuk ditampilkan',
                    size: 18.0,
                    isBold: true,
                    color: GlobalColor.defaultBlue,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            GlobalElevatedButton(
              title: 'Simpan',
              onPressed: () {
                GlobalRoute(context: context).back(null);
              },
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
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