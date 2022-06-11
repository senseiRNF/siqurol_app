import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/workshop_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

// User Form Screen ------------------------------------------------------------
class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController participantNameTEC = TextEditingController();
  TextEditingController instanceNameTEC = TextEditingController();
  TextEditingController workshopPlaceTEC = TextEditingController();
  TextEditingController attendedWorkshopTEC = TextEditingController();

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
                          controller: instanceNameTEC,
                          title: 'Nama Instansi',
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
                          controller: attendedWorkshopTEC,
                          title: 'Pelatihan Yang Diikuti',
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

// Admin Participant Screen ----------------------------------------------------
class ParticipantScreen extends StatefulWidget {
  const ParticipantScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantScreen> createState() => _ParticipantScreenState();
}

class _ParticipantScreenState extends State<ParticipantScreen> {
  List<ParticipantData> workshopDataList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      workshopDataList = [
        ParticipantData(
          participantName: 'Dian Utami',
          instanceName: 'PT. ABC',
          workshopPlace: 'Bogor',
        ),
        ParticipantData(
          participantName: 'Mawar Sekar Ayu',
          instanceName: 'PT. DEF',
          workshopPlace: 'Jakarta',
        ),
        ParticipantData(
          participantName: 'Eka Saputra',
          instanceName: 'PT. GHI',
          workshopPlace: 'Jakarta',
        ),
        ParticipantData(
          participantName: 'Eka Saputra',
          instanceName: 'PT. JKL',
          workshopPlace: 'Bogor',
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
              content: 'Data Peserta',
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
                child: workshopDataList.isNotEmpty ?
                ListView.builder(
                  itemCount: workshopDataList.length,
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
                                      content: workshopDataList[index].participantName,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalText(
                                      content: workshopDataList[index].instanceName,
                                      align: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: GlobalText(
                                      content: workshopDataList[index].workshopPlace,
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
            workshopDataList.isNotEmpty ?
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