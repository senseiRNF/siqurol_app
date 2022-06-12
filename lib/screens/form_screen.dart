import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

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
              content: 'Form',
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
                      child: InkWell(
                        onTap: () {

                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0,),
                          child: Row(
                            children: const [
                              Expanded(
                                child: GlobalText(
                                  content: 'Pelatihan Yang Diikuti',
                                  size: 18.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                                child: Icon(
                                  Icons.expand_more,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
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
                    )
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