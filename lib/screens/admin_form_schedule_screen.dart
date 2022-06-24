import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/data_classes/training_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/local_db.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';

class AdminFormScheduleScreen extends StatefulWidget {
  const AdminFormScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AdminFormScheduleScreen> createState() => _AdminFormScheduleScreenState();
}

class _AdminFormScheduleScreenState extends State<AdminFormScheduleScreen> {
  TextEditingController speakerTEC = TextEditingController();

  DateTime selectedDateTime = DateTime.now();
  TimeOfDay selectedHour = TimeOfDay.now();

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
              child: ListView(
                children: [
                  Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2032),
                        ).then((dateResult) async {
                          await showTimePicker(
                            context: context,
                            initialTime: selectedHour,
                          ).then((hourResult) {
                            if(dateResult != null && hourResult != null) {
                              setState(() {
                                selectedDateTime = dateResult;
                                selectedHour = hourResult;
                              });
                            }
                          });
                        });
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0,),
                      ),
                      child: GlobalPadding(
                        paddingClass: const GlobalPaddingClass(
                          paddingLeft: 20.0,
                          paddingTop: 20.0,
                          paddingRight: 20.0,
                          paddingBottom: 20.0,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const GlobalText(
                              content: 'Pilih Tanggal',
                              size: 18.0,
                              isBold: true,
                              padding: GlobalPaddingClass(
                                paddingBottom: 20.0,
                              ),
                            ),
                            GlobalText(
                              content: DateFormat('dd/MM/yyyy').format(selectedDateTime),
                              size: 16.0,
                            ),
                            GlobalText(
                              content: DateFormat('HH:mm').format(
                                DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  selectedHour.hour,
                                  selectedHour.minute,
                                ),
                              ),
                              size: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GlobalTextfield(
                    controller: speakerTEC,
                    title: 'Pembicara',
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                  ),
                  GlobalElevatedButton(
                    onPressed: () async {
                      await LocalDB().writeTraining(
                        TrainingData(
                          date: selectedDateTime,
                          hour: selectedHour,
                          speaker: speakerTEC.text,
                        ),
                      ).then((result) {
                        if(result) {
                          GlobalRoute(context: context).back(true);
                        } else {
                          GlobalDialog(context: context, message: 'Gagal membuat jadwal, silahkan coba lagi').okDialog(() {

                          });
                        }
                      });
                    },
                    title: 'Simpan',
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
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