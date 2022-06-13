import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/schedule_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
  List<ScheduleData> scheduleDataList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      scheduleDataList = [
        ScheduleData(
          zoomLink: 'https://www.abcde.com',
          workshopDate: DateTime(2022, 06, 13),
          workshopTime: '10.00',
        ),
        ScheduleData(
          zoomLink: 'https://www.fghij.com',
          workshopDate: DateTime(2022, 06, 15),
          workshopTime: '09.00',
        ),
        ScheduleData(
          zoomLink: 'https://www.klmno.com',
          workshopDate: DateTime(2022, 06, 17),
          workshopTime: '08.00',
        ),
      ];
    });
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
              content: 'Jadwal Peserta',
              size: 26.0,
              color: GlobalColor.defaultBlue,
              isBold: true,
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingTop: 10.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: scheduleDataList.isNotEmpty ?
                ListView.builder(
                  itemCount: scheduleDataList.length,
                  itemBuilder: (BuildContext workshopListContext, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GlobalText(
                                  content: scheduleDataList[index].zoomLink,
                                  align: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: GlobalText(
                                  content: DateFormat('dd/MM/yyyy').format(scheduleDataList[index].workshopDate),
                                  align: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: GlobalText(
                                  content: scheduleDataList[index].workshopTime,
                                  align: TextAlign.center,
                                ),
                              ),
                              const Icon(
                                Icons.edit,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ) :
                Center(
                  child: GlobalText(
                    content: 'Daftar Tidak Tersedia...',
                    size: 26.0,
                    color: GlobalColor.defaultBlue,
                  ),
                ),
              ),
            ),
            scheduleDataList.isNotEmpty ?
            GlobalElevatedButton(
              onPressed: () {

              },
              title: 'Tambah Data',
              padding: const GlobalPaddingClass(
                paddingTop: 20.0,
                paddingBottom: 20.0,
              ),
            ) :
            const Material(),
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