import 'package:flutter/material.dart';
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
  ScheduleData? scheduleData;

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
              ListView() :
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