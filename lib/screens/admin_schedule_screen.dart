import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/screens/admin_form_schedule_screen.dart';
import 'package:siqurol_app/screens/admin_participant_training_screen.dart';
import 'package:siqurol_app/services/local_db.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
  List<TrainingData> trainingList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await LocalDB().readAllTraining().then((result) {
      setState(() {
        trainingList = result;
      });
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
              content: 'Jadwal Kegiatan',
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
              child: trainingList.isNotEmpty ?
              ListView.builder(
                itemCount: trainingList.length,
                itemBuilder: (BuildContext scheduleContext, int index) {
                  return Card(
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
                          Row(
                            children: [
                              Expanded(
                                child: GlobalText(
                                  content: trainingList[index].date != null ? DateFormat('dd/MM/yyyy').format(trainingList[index].date!) : 'Tanggal Tak Diketahui',
                                  color: GlobalColor.defaultBlue,
                                  size: 18.0,
                                  isBold: true,
                                  padding: const GlobalPaddingClass(
                                    paddingBottom: 10.0,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  GlobalRoute(context: context).moveTo(AdminParticipantTrainingScreen(trainingData: trainingList[index]), (callback) {
                                    if(callback != null && callback) {
                                      initLoad();
                                    }
                                  });
                                },
                                customBorder: const CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0,),
                                  child: Icon(
                                    Icons.person_add,
                                    color: GlobalColor.defaultBlue,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  GlobalRoute(context: context).moveTo(AdminFormScheduleScreen(
                                    trainingData: trainingList[index],
                                  ), (callback) {
                                    if(callback != null && callback) {
                                      initLoad();
                                    }
                                  });
                                },
                                customBorder: const CircleBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0,),
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GlobalText(
                                content: "Pembicara: ${trainingList[index].speaker ?? 'Pembicara Tak Diketahui'}",
                              ),
                            ],
                          )
                        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalRoute(context: context).moveTo(const AdminFormScheduleScreen(), (callback) {
            if(callback != null && callback) {
              initLoad();
            }
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}