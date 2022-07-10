import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/api_services/certificate_services.dart';
import 'package:siqurol_app/services/api_services/training_services.dart';
import 'package:siqurol_app/services/api_services/user_services.dart';
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
  List<TrainingParticipantData> participantList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await TrainingServices().readTrainingParticipant(widget.trainingData.scheduleId!).then((tpList) async {
      if(tpList.isNotEmpty) {
        await UserServices().readUserOnly().then((participant) {
          List<TrainingParticipantData> tempParticipantList = [];

          for(int j = 0; j < participant.length; j++) {
            for(int k = 0; k < tpList.length; k++) {
              if(participant[j].userId == tpList[k].auth.userId) {
                tempParticipantList.add(
                  TrainingParticipantData(
                    auth: participant[j],
                    isChecked: tpList[k].isChecked,
                  ),
                );
              }
            }
          }

          setState(() {
            participantList = tempParticipantList;
          });
        });
      } else {
        GlobalDialog(context: context, message: 'Belum ada peserta terdaftar di acara ini').okDialog(() {
          GlobalRoute(context: context).back(null);
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
              content: 'Daftar Penyerahan Sertifikat',
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
                        onChanged: (checked) async {
                          if(checked!) {
                            await CertificateServices().updateCertificateParticipant(
                              'received',
                              widget.trainingData.scheduleId!,
                              participantList[index].auth,
                            ).then((result) {
                              if(result) {
                                GlobalDialog(context: context, message: 'Sukses mengubah data').okDialog(() {
                                  setState(() {
                                    participantList[index].isChecked = true;
                                  });
                                });
                              } else {
                                GlobalDialog(context: context, message: 'Gagal mengubah data').okDialog(() {

                                });
                              }
                            });
                          } else {
                            await CertificateServices().updateCertificateParticipant(
                              'detained',
                              widget.trainingData.scheduleId!,
                              participantList[index].auth,
                            ).then((result) {
                              if(result) {
                                GlobalDialog(context: context, message: 'Sukses mengubah data').okDialog(() {
                                  setState(() {
                                    participantList[index].isChecked = false;
                                  });
                                });
                              } else {
                                GlobalDialog(context: context, message: 'Gagal mengubah data').okDialog(() {

                                });
                              }
                            });
                          }
                        },
                        value: participantList[index].isChecked,
                        title: GlobalText(
                          content: participantList[index].auth.name ?? 'Nama Tak Diketahui',
                          size: 18.0,
                          isBold: true,
                        ),
                        subtitle: GlobalText(
                          content: participantList[index].auth.email ?? 'Email Tak Diketahui',
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