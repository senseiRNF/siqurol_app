import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/workshop_schedule_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

// User Form Screen ------------------------------------------------------------
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  TextEditingController participantNameTEC = TextEditingController();
  TextEditingController zoomLinkTEC = TextEditingController();
  TextEditingController workshopPlaceTEC = TextEditingController();
  TextEditingController workshopDateTEC = TextEditingController();

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListView(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0,),
                        child: GlobalTextfield(
                          controller: participantNameTEC,
                          title: 'Nama Peserta',
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0,),
                        child: GlobalTextfield(
                          controller: zoomLinkTEC,
                          title: 'Zoom Link',
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0,),
                        child: GlobalTextfield(
                          controller: workshopPlaceTEC,
                          title: 'Tempat Pelatihan',
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0,),
                        child: GlobalTextfield(
                          controller: workshopDateTEC,
                          title: 'Tanggal Pelatihan',
                        ),
                      ),
                    ),
                    GlobalElevatedButton(
                      onPressed: () {

                      },
                      title: 'Simpan',
                      padding: const GlobalPaddingClass(
                        paddingTop: 20.0,
                        paddingBottom: 20.0,
                      ),
                    ),
                  ],
                ),
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

// Admin Participant Screen ----------------------------------------------------
class ParticipantScheduleScreen extends StatefulWidget {
  const ParticipantScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantScheduleScreen> createState() => _ParticipantScheduleScreenState();
}

class _ParticipantScheduleScreenState extends State<ParticipantScheduleScreen> {
  List<ScheduleData> scheduleDataList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      scheduleDataList = [
        ScheduleData(
          participantName: 'Arman Ikhsan',
          zoomLink: 'https://www.abcde.com',
          workshopDate: '11 Juni 2022',
        ),
        ScheduleData(
          participantName: 'Indah Pratama Putri',
          zoomLink: 'https://www.fghij.com',
          workshopDate: '13 Juni 2022',
        ),
        ScheduleData(
          participantName: 'Julia Sabina',
          zoomLink: 'https://www.klmno.com',
          workshopDate: '16 Juni 2022',
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
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0,),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0,),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GlobalText(
                                      content: scheduleDataList[index].participantName,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalText(
                                      content: scheduleDataList[index].workshopDate,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalText(
                                      content: scheduleDataList[index].zoomLink,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GlobalTextButton(
                          onPressed: () {

                          },
                          title: 'Edit',
                          titleColor: GlobalColor.defaultBlue,
                        ),
                      ],
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