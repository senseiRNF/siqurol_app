import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/schedule_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleData? scheduleData = ScheduleData(
    zoomLink: 'https://www.example.com',
    workshopDate: DateTime(2022, 06, 13),
    workshopTime: '10:00',
  );

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
            ScreenHeader(
              onBackPressed: () {
                GlobalRoute(context: context).back(null);
              },
            ),
            GlobalText(
              content: 'Jadwal',
              size: 26.0,
              color: GlobalColor.defaultBlue,
              isBold: true,
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingTop: 10.0,
              ),
            ),
            Expanded(
              child: scheduleData != null ?
              ListView(
                children: [
                  InkWell(
                    onTap: () {

                    },
                    borderRadius: BorderRadius.circular(4.0,),
                    child: Column(
                      children: [
                        const GlobalText(
                          content: 'Anda dijadwalkan untuk mengikuti pelatihan pada:',
                          size: 16.0,
                          padding: GlobalPaddingClass(
                            paddingTop: 10.0,
                            paddingBottom: 10.0,
                          ),
                        ),
                        GlobalText(
                          content: "${DateFormat('dd MMMM yyyy').format(scheduleData!.workshopDate)} ${scheduleData!.workshopTime}",
                          size: 26.0,
                          isBold: true,
                          padding: const GlobalPaddingClass(
                            paddingBottom: 10.0,
                          ),
                        ),
                        const GlobalText(
                          content: 'Zoom Link',
                          size: 16.0,
                        ),
                        GlobalText(
                          content: scheduleData!.zoomLink,
                          size: 20.0,
                          padding: const GlobalPaddingClass(
                            paddingBottom: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        '${GlobalString.assetImagePath}/schedule_icon.png',
                        height: 80.0,
                      ),
                      const GlobalText(
                        content: 'Jadwal Tidak Ditemukan...',
                        size: 20.0,
                        isBold: true,
                        align: TextAlign.center,
                        padding: GlobalPaddingClass(
                          paddingTop: 20.0,
                        ),
                      ),
                      const GlobalText(
                        content: 'Usap kebawah untuk memperbaharui data',
                        size: 16.0,
                        align: TextAlign.center,
                        padding: GlobalPaddingClass(
                          paddingBottom: 20.0,
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: ListView(

                    ),
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