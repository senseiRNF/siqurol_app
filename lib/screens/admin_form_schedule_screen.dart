import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
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
  TextEditingController capacityTEC = TextEditingController();

  DateTime selectedDateTime = DateTime.now();

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
                paddingBottom: 10.0,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GlobalElevatedButton(
                    onPressed: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2032),
                      ).then((result) {
                        if(result != null) {
                          setState(() {
                            selectedDateTime = result;
                          });
                        }
                      });
                    },
                    title: 'Pilih Tanggal\n\n${DateFormat('dd/MM/yyyy').format(selectedDateTime)}',
                    titleColor: GlobalColor.defaultWhite,
                    btnColor: Colors.grey,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                  ),
                  GlobalTextfield(
                    controller: speakerTEC,
                    title: 'Narasumber',
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                  ),
                  GlobalTextfield(
                    controller: capacityTEC,
                    title: 'Jumlah Slot Peserta',
                    inputType: TextInputType.number,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                  ),
                  GlobalElevatedButton(
                    onPressed: () {
                      GlobalRoute(context: context).back(null);
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