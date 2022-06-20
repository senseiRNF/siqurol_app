import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {

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
            const GlobalHeader(),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0,),
                child: Builder(
                  builder: (BuildContext calendarContext) {
                    return CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2032),
                      onDateChanged: (DateTime dateTime) {
                        DateTime dateNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

                        TextEditingController speakerTEC = TextEditingController();
                        TextEditingController capacityTEC = TextEditingController();

                        if(dateTime.isAfter(dateNow)) {
                          Scaffold.of(calendarContext).showBottomSheet((BuildContext bottomContext) {
                            return Container(
                              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    GlobalText(
                                      content: DateFormat('dd MMMM yyyy').format(dateTime),
                                      size: 20.0,
                                      isBold: true,
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalTextfield(
                                      controller: speakerTEC,
                                      title: 'Narasumber',
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingTop: 10.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalTextfield(
                                      controller: capacityTEC,
                                      title: 'Kapasitas',
                                      inputType: TextInputType.number,
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingTop: 10.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalElevatedButton(
                                      onPressed: () async {
                                        GlobalRoute(context: context).back(null);
                                      },
                                      title: 'Simpan',
                                      titleSize: 18.0,
                                      btnColor: GlobalColor.defaultBlue,
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 40.0,
                                        paddingTop: 20.0,
                                        paddingRight: 40.0,
                                        paddingBottom: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }, shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0,),
                              topRight: Radius.circular(30.0,),
                            ),
                          ));
                        } else {
                          String speakerName = 'Mr. Speaker';
                          int capacity = 30;

                          Scaffold.of(calendarContext).showBottomSheet((BuildContext bottomContext) {
                            return Container(
                              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    GlobalText(
                                      content: DateFormat('dd MMMM yyyy').format(dateTime),
                                      size: 20.0,
                                      isBold: true,
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalText(
                                      content: 'Narasumber: $speakerName',
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingTop: 10.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalText(
                                      content: 'Kapasitas: $capacity',
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 50.0,
                                        paddingTop: 10.0,
                                        paddingRight: 50.0,
                                      ),
                                    ),
                                    GlobalElevatedButton(
                                      onPressed: () async {
                                        GlobalRoute(context: context).back(null);
                                      },
                                      title: 'Lihat Detail',
                                      titleSize: 18.0,
                                      btnColor: GlobalColor.defaultBlue,
                                      padding: const GlobalPaddingClass(
                                        paddingLeft: 40.0,
                                        paddingTop: 20.0,
                                        paddingRight: 40.0,
                                        paddingBottom: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }, shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0,),
                              topRight: Radius.circular(30.0,),
                            ),
                          ));
                        }
                      },
                    );
                  },
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