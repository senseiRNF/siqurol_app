import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/form_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_input_field.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';

class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({Key? key}) : super(key: key);

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
  TextEditingController participantName = TextEditingController();
  TextEditingController instanceName = TextEditingController();
  TextEditingController workshopPlace = TextEditingController();
  TextEditingController workshopType = TextEditingController();

  List<FormData> workshopDataList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      workshopDataList = [
        FormData(
          participantName: 'Dian Utami',
          instanceName: 'PT. ABC',
          workshopPlace: 'Bogor',
        ),
        FormData(
          participantName: 'Mawar Sekar Ayu',
          instanceName: 'PT. DEF',
          workshopPlace: 'Jakarta',
        ),
        FormData(
          participantName: 'Eka Saputra',
          instanceName: 'PT. GHI',
          workshopPlace: 'Jakarta',
        ),
        FormData(
          participantName: 'Jajang Sudrajat',
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
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0,),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2027),
                          ).then((DateTime? result) {
                            if(result != null) {
                              setState(() {
                                workshopDataList[index].workshopDate = result;
                              });
                            }
                          });
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
                              workshopDataList[index].workshopDate != null ?
                              Icon(
                                Icons.check,
                                color: GlobalColor.defaultGreen,
                              ) :
                              Icon(
                                Icons.highlight_remove,
                                color: GlobalColor.defaultRed,
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
            workshopDataList.isNotEmpty ?
            Builder(
              builder: (BuildContext bottomContext) {
                return GlobalElevatedButton(
                  onPressed: () {
                    Scaffold.of(bottomContext).showBottomSheet((BuildContext bottomSheetcontext) {
                      return Container(
                        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
                        decoration: BoxDecoration(
                          color: GlobalColor.defaultWhite,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0,),
                            topRight: Radius.circular(30.0,),
                          ),
                        ),
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                  GlobalRoute(context: context).back(null);
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
                      );
                    });
                  },
                  title: 'Tambah Data',
                  padding: const GlobalPaddingClass(
                    paddingTop: 20.0,
                    paddingBottom: 20.0,
                  ),
                );
              },
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