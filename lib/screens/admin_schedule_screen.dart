import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/screens/admin_form_schedule_screen.dart';
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
  List<TrainingData> scheduleList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await LocalDB().readAllTraining().then((result) {
      setState(() {
        scheduleList = result;
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
              child: scheduleList.isNotEmpty ?
              ListView.builder(
                itemCount: scheduleList.length,
                itemBuilder: (BuildContext scheduleContext, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {

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
                              content: scheduleList[index].date != null ? DateFormat('dd/MM/yyyy').format(scheduleList[index].date!) : 'Tanggal Tak Diketahui',
                              color: GlobalColor.defaultBlue,
                              size: 18.0,
                              isBold: true,
                              padding: const GlobalPaddingClass(
                                paddingBottom: 10.0,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GlobalText(
                                  content: "Pembicara: ${scheduleList[index].speaker ?? 'Pembicara Tak Diketahui'}",
                                ),
                                GlobalText(
                                  content: "Jumlah Peserta: ${scheduleList[index].numberOfParticipant != null ? scheduleList[index].numberOfParticipant!.toString() : 'Jumlah Peserta Tak Diketahui'}",
                                ),
                              ],
                            )
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