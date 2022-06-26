import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/local_db.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class AdminParticipantTrainingScreen extends StatefulWidget {
  final TrainingData trainingData;

  const AdminParticipantTrainingScreen({
    Key? key,
    required this.trainingData,
  }) : super(key: key);

  @override
  State<AdminParticipantTrainingScreen> createState() => _AdminParticipantTrainingScreenState();
}

class _AdminParticipantTrainingScreenState extends State<AdminParticipantTrainingScreen> {
  List<TrainingParticipantData> trainingParticipantList = [];
  
  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await LocalDB().readTrainingParticipant(widget.trainingData.scheduleId!).then((tpList) async {
      if(tpList.isNotEmpty) {
        await LocalDB().readOnlyUserRole().then((participant) {
          List<TrainingParticipantData> tempTrainingParticipantList = [];

          for(int i = 0; i < participant.length; i++) {
            tempTrainingParticipantList.add(
              TrainingParticipantData(
                participant: participant[i],
                isChecked: false,
              ),
            );
          }

          for(int j = 0; j < participant.length; j++) {
            for(int k = 0; k < tpList.length; k++) {
              if(participant[j].userId == tpList[k].userId) {
                tempTrainingParticipantList[j] = TrainingParticipantData(
                  participant: participant[j],
                  isChecked: true,
                );
              }
            }
          }

          setState(() {
            trainingParticipantList = tempTrainingParticipantList;
          });
        });
      } else {
        await LocalDB().readOnlyUserRole().then((participant) {
          List<TrainingParticipantData> tempTrainingParticipantList = [];

          for(int i = 0; i < participant.length; i++) {
            tempTrainingParticipantList.add(
              TrainingParticipantData(
                participant: participant[i],
                isChecked: false,
              ),
            );
          }

          setState(() {
            trainingParticipantList = tempTrainingParticipantList;
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
              child: trainingParticipantList.isNotEmpty ?
              ListView.builder(
                itemCount: trainingParticipantList.length,
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
                          bool changed = trainingParticipantList[index].isChecked;

                          setState(() {
                            trainingParticipantList[index].isChecked = !changed;
                          });
                        },
                        value: trainingParticipantList[index].isChecked,
                        title: GlobalText(
                          content: trainingParticipantList[index].participant.name ?? 'Nama Tak Diketahui',
                          size: 18.0,
                          isBold: true,
                        ),
                        subtitle: GlobalText(
                          content: trainingParticipantList[index].participant.email ?? 'Email Tak Diketahui',
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
                GlobalDialog(context: context, message: 'Simpan data, Anda yakin?').optionDialog(() async {
                  for(int i = 0; i < trainingParticipantList.length; i++) {
                    if(trainingParticipantList[i].isChecked) {
                      await LocalDB().writeTrainingParticipant(
                        widget.trainingData.scheduleId!,
                        trainingParticipantList[i].participant,
                      );
                    }

                    if(i == trainingParticipantList.length - 1) {
                      GlobalRoute(context: context).back(true);
                    }
                  }
                }, () {

                });
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