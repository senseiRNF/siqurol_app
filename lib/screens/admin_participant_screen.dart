import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/api_services/user_services.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminParticipantScreen extends StatefulWidget {
  const AdminParticipantScreen({Key? key}) : super(key: key);

  @override
  State<AdminParticipantScreen> createState() => _AdminParticipantScreenState();
}

class _AdminParticipantScreenState extends State<AdminParticipantScreen> {
  List<AuthData> participantList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await UserServices().readUserOnly().then((user) {
      setState(() {
        participantList = user;
      });
    });
  }

  Widget initStatusWidget(String status) {
    switch(status) {
      case 'inactive':
        return GlobalText(
          content: 'Belum Aktif',
          align: TextAlign.end,
          size: 18.0,
          color: GlobalColor.defaultRed,
        );
      case 'on-review':
        return GlobalText(
          content: 'Menunggu Seleksi',
          align: TextAlign.end,
          size: 18.0,
          color: GlobalColor.defaultBlue,
        );
      case 'rejected':
        return GlobalText(
          content: 'Ditolak',
          align: TextAlign.end,
          size: 18.0,
          color: GlobalColor.defaultRed,
        );
      case 'active':
        return GlobalText(
          content: 'Aktif',
          align: TextAlign.end,
          size: 18.0,
          color: GlobalColor.defaultGreen,
        );
      default:
        return const Material();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GlobalHeader(),
            GlobalText(
              content: 'Data Peserta',
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
              child: participantList.isNotEmpty ?
              ListView.builder(
                itemCount: participantList.length,
                itemBuilder: (BuildContext participantContext, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        if(participantList[index].status != null) {
                          if(participantList[index].status! == 'on-review') {
                            GlobalDialog(context: context, message: 'Konfirmasi peserta, apakah dapat melanjutkan ke pembagian jadwal?').optionDialog(() {
                              GlobalDialog(context: context, message: 'Status selanjutnya: "AKTIF", Anda yakin?').optionDialog(() async {
                                await UserServices().updateUserStatus(
                                  AuthData(
                                    userId: participantList[index].userId,
                                    status: 'active',
                                  ),
                                ).then((result) {
                                  if(result) {
                                    initLoad();
                                  }
                                });
                              }, () {

                              });
                            }, () {
                              GlobalDialog(context: context, message: 'Status selanjutnya: "DITOLAK", Anda yakin?').optionDialog(() async {
                                await UserServices().updateUserStatus(
                                  AuthData(
                                    userId: participantList[index].userId,
                                    status: 'rejected',
                                  ),
                                ).then((result) {
                                  if(result) {
                                    initLoad();
                                  }
                                });
                              }, () {

                              });
                            });
                          } else if(participantList[index].status! == 'rejected') {
                            GlobalDialog(context: context, message: 'Status peserta saat ini "DITOLAK", apakah ingin kembali ke proses seleksi?').optionDialog(() {
                              GlobalDialog(context: context, message: 'Status selanjutnya: "MENUNGGU SELEKSI", Anda yakin?').optionDialog(() async {
                                await UserServices().updateUserStatus(
                                  AuthData(
                                    userId: participantList[index].userId,
                                    status: 'on-review',
                                  ),
                                ).then((result) {
                                  if(result) {
                                    initLoad();
                                  }
                                });
                              }, () {

                              });
                            }, () {

                            });
                          }
                        }
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0,),
                      ),
                      child: ListTile(
                        title: GlobalText(
                          content: participantList[index].name ?? 'Nama Tak Diketahui',
                          color: GlobalColor.defaultBlue,
                          size: 18.0,
                          isBold: true,
                        ),
                        subtitle: GlobalPadding(
                          paddingClass: const GlobalPaddingClass(
                            paddingTop: 10.0,
                            paddingBottom: 10.0,
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GlobalText(
                                content: participantList[index].email ?? 'Email Tak Diketahui',
                              ),
                              GlobalText(
                                content: participantList[index].phone ?? 'Telepon Tak Diketahui',
                              ),
                              GlobalText(
                                content: participantList[index].address ?? 'Alamat Tak Diketahui',
                              ),
                              initStatusWidget(participantList[index].status ?? 'Status Tak Diketahui'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlobalText(
                    content: 'Belum ada data untuk ditampilkan',
                    size: 18.0,
                    isBold: true,
                    color: GlobalColor.defaultBlue,
                    align: TextAlign.center,
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