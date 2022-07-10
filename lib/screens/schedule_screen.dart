import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/screens/detail_schedule_screen.dart';
import 'package:siqurol_app/services/api_services/training_services.dart';
import 'package:siqurol_app/services/shared_preferences.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<TrainingData> scheduleList = [];

  String? username;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((auth) async {
      if(auth != null && auth.userId != null) {
        setState(() {
          username = auth.name;
        });

        await TrainingServices().readTrainingByUser(auth.userId!).then((result) async {
          setState(() {
            scheduleList = result;
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
          children: [
            const GlobalHeader(),
            GlobalText(
              content: 'Jadwal',
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
                itemBuilder: (BuildContext listContext, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        GlobalRoute(context: context).moveTo(DetailScheduleScreen(
                          trainingData: scheduleList[index],
                          username: username!,
                        ), (callback) {

                        });
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
                              content: "Tanggal: ${scheduleList[index].date != null ? DateFormat('dd/MM/yyyy').format(scheduleList[index].date!) : 'Tanggal Tak Diketahui'}",
                              color: GlobalColor.defaultBlue,
                              size: 18.0,
                              isBold: true,
                            ),
                            GlobalText(
                              content: "Jam: ${scheduleList[index].hour != null ? DateFormat('HH:mm').format(DateTime(scheduleList[index].date!.year, scheduleList[index].date!.month, scheduleList[index].date!.day, scheduleList[index].hour!.hour, scheduleList[index].hour!.minute)) : 'Waktu Tak Diketahui'}",
                              color: GlobalColor.defaultBlue,
                              size: 18.0,
                              isBold: true,
                              padding: const GlobalPaddingClass(
                                paddingBottom: 10.0,
                              ),
                            ),
                            GlobalText(
                              content: "Pembicara: ${scheduleList[index].speaker ?? 'Pembicara Tak Diketahui'}",
                            ),
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
                    content: 'Belum ada jadwal untuk ditampilkan',
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