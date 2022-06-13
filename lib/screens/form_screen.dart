import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController participantName = TextEditingController();
  TextEditingController instanceName = TextEditingController();
  TextEditingController workshopPlace = TextEditingController();
  TextEditingController workshopType = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              onBackPressed: () {
                GlobalRoute(context: context).back(null);
              },
            ),
            GlobalText(
              content: 'Formulir',
              size: 26.0,
              color: GlobalColor.defaultBlue,
              isBold: true,
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingTop: 10.0,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GlobalTextfield(
                    controller: participantName,
                    title: 'Nama Lengkap',
                    capitalization: TextCapitalization.words,
                    isBordered: true,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingTop: 20.0,
                    ),
                  ),
                  GlobalTextfield(
                    controller: instanceName,
                    title: 'Nama Instansi',
                    capitalization: TextCapitalization.words,
                    isBordered: true,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingTop: 20.0,
                    ),
                  ),
                  GlobalTextfield(
                    controller: workshopPlace,
                    title: 'Tempat Pelatihan',
                    capitalization: TextCapitalization.words,
                    isBordered: true,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingTop: 20.0,
                    ),
                  ),
                  GlobalTextfield(
                    controller: workshopType,
                    title: 'Pelatihan Yang Diikuti',
                    capitalization: TextCapitalization.words,
                    isBordered: true,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingTop: 20.0,
                    ),
                  ),
                  GlobalElevatedButton(
                    onPressed: () {

                    },
                    title: 'Simpan',
                    padding: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingTop: 20.0,
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