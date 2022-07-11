import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_participant_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/api_services/training_services.dart';
import 'package:siqurol_app/services/api_services/user_services.dart';
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
    await TrainingServices().readTrainingParticipant(widget.trainingData.scheduleId!).then((tpList) async {
      if(tpList.isNotEmpty) {
        await UserServices().readUserOnly().then((participant) {
          List<TrainingParticipantData> tempTrainingParticipantList = [];

          for(int i = 0; i < participant.length; i++) {
            if(participant[i].status == 'active') {
              tempTrainingParticipantList.add(
                TrainingParticipantData(
                  auth: participant[i],
                  isChecked: false,
                ),
              );
            }
          }

          for(int j = 0; j < participant.length; j++) {
            for(int k = 0; k < tpList.length; k++) {
              if(participant[j].userId == tpList[k].auth.userId) {
                tempTrainingParticipantList[j] = TrainingParticipantData(
                  auth: participant[j],
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
        await UserServices().readUserOnly().then((participant) {
          List<TrainingParticipantData> tempTrainingParticipantList = [];

          for(int i = 0; i < participant.length; i++) {
            if(participant[i].status == 'active') {
              tempTrainingParticipantList.add(
                TrainingParticipantData(
                  auth: participant[i],
                  isChecked: false,
                ),
              );
            }
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
                        onChanged: (checked) async {
                          if(checked!) {
                            await TrainingServices().createTrainingParticipant(
                              widget.trainingData.scheduleId!,
                              trainingParticipantList[index].auth,
                            ).then((result) {
                              if(result) {
                                GlobalDialog(context: context, message: 'Sukses menambahkan peserta').okDialog(() {
                                  setState(() {
                                    trainingParticipantList[index].isChecked = true;
                                  });
                                });
                              } else {
                                GlobalDialog(context: context, message: 'Gagal menambahkan peserta').okDialog(() {

                                });
                              }
                            });
                          } else {
                            await TrainingServices().readTrainingParticipant(widget.trainingData.scheduleId!).then((checkCertificate) async {
                              for(int i = 0; i < checkCertificate.length; i++) {
                                if(trainingParticipantList[index].auth.userId == checkCertificate[i].auth.userId) {
                                  if(checkCertificate[i].isChecked) {
                                    GlobalDialog(context: context, message: 'Tidak dapat menghapus peserta, sertifikat sudah diserahkan').okDialog(() {

                                    });
                                  } else {
                                    await TrainingServices().deleteTrainingParticipant(
                                      widget.trainingData.scheduleId!,
                                      trainingParticipantList[index].auth,
                                    ).then((result) {
                                      if(result) {
                                        GlobalDialog(context: context, message: 'Sukses menghapus peserta').okDialog(() {
                                          setState(() {
                                            trainingParticipantList[index].isChecked = false;
                                          });
                                        });
                                      } else {
                                        GlobalDialog(context: context, message: 'Gagal menghapus peserta').okDialog(() {

                                        });
                                      }
                                    });
                                  }
                                }
                              }
                            });
                          }
                        },
                        value: trainingParticipantList[index].isChecked,
                        title: GlobalText(
                          content: trainingParticipantList[index].auth.name ?? 'Nama Tak Diketahui',
                          size: 18.0,
                          isBold: true,
                        ),
                        subtitle: GlobalText(
                          content: trainingParticipantList[index].auth.email ?? 'Email Tak Diketahui',
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