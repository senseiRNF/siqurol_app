import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/data_classes/main_menu_data.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/admin_certificate_screen.dart';
import 'package:siqurol_app/screens/admin_schedule_screen.dart';
import 'package:siqurol_app/screens/certificate_screen.dart';
import 'package:siqurol_app/screens/help_screen.dart';
import 'package:siqurol_app/screens/profile_screen.dart';
import 'package:siqurol_app/screens/schedule_screen.dart';
import 'package:siqurol_app/screens/splash_screen.dart';
import 'package:siqurol_app/screens/admin_participant_screen.dart';
import 'package:siqurol_app/services/api_services/user_services.dart';
import 'package:siqurol_app/services/shared_preferences.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/home_screen_widgets/home_main_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MainMenuData> mainMenu = [];

  AuthData? authData;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((spAuth) {
      if(spAuth != null && spAuth.role != null && spAuth.status != null) {
        setState(() {
          authData = AuthData(
            userId: spAuth.userId,
            email: spAuth.email,
            name: spAuth.name,
            phone: spAuth.phone,
            address: spAuth.address,
            role: spAuth.role,
            status: spAuth.status,
          );
        });

        if(spAuth.role == 'admin') {
          setState(() {
            mainMenu = [
              MainMenuData(
                imagePath: '${GlobalString.assetImagePath}/profile_icon.png',
                title: 'Profil',
                onPressed: () {
                  GlobalRoute(context: context).moveTo(const ProfileScreen(), (callback) {

                  });
                },
              ),
              MainMenuData(
                imagePath: '${GlobalString.assetImagePath}/participant_icon.png',
                title: 'Data Peserta',
                onPressed: () {
                  GlobalRoute(context: context).moveTo(const AdminParticipantScreen(), (callback) {

                  });
                },
              ),
              MainMenuData(
                imagePath: '${GlobalString.assetImagePath}/schedule_icon.png',
                title: 'Jadwal Kegiatan',
                onPressed: () {
                  GlobalRoute(context: context).moveTo(const AdminScheduleScreen(), (callback) {

                  });
                },
              ),
              MainMenuData(
                imagePath: '${GlobalString.assetImagePath}/certificate_icon.png',
                title: 'Sertifikat',
                onPressed: () {
                  GlobalRoute(context: context).moveTo(const AdminCertificateScreen(), (callback) {

                  });
                },
              ),
            ];
          });
        } else {
          if(spAuth.status == 'active') {
            setState(() {
              mainMenu = [
                MainMenuData(
                  imagePath: '${GlobalString.assetImagePath}/profile_icon.png',
                  title: 'Profil',
                  onPressed: () {
                    GlobalRoute(context: context).moveTo(const ProfileScreen(), (callback) {

                    });
                  },
                ),
                MainMenuData(
                  imagePath: '${GlobalString.assetImagePath}/schedule_icon.png',
                  title: 'Jadwal',
                  onPressed: () {
                    GlobalRoute(context: context).moveTo(const ScheduleScreen(), (callback) {

                    });
                  },
                ),
                MainMenuData(
                  imagePath: '${GlobalString.assetImagePath}/certificate_icon.png',
                  title: 'Sertifikat',
                  onPressed: () {
                    GlobalRoute(context: context).moveTo(const CertificateScreen(), (callback) {

                    });
                  },
                ),
                MainMenuData(
                  imagePath: 'help icon',
                  title: 'Panduan Pengguna',
                  onPressed: () {
                    GlobalRoute(context: context).moveTo(const HelpScreen(), (callback) {

                    });
                  },
                ),
              ];
            });
          } else {
            setState(() {
              mainMenu = [];
            });
          }
        }
      }
    });
  }

  String textLoad() {
    String result = '';

    if(authData != null && authData!.status != null) {
      switch(authData!.status) {
        case 'inactive':
          result = 'Akun Anda belum belum aktif dan perlu mengikuti tahapan seleksi, silahkan tekan tombol dibawah ini';
          break;
        case 'on-review':
          result = 'Akun Anda sedang dalam tahap seleksi, mohon untuk menunggu';
          break;
        case 'rejected':
          result = 'Akun Anda tidak lolos pada tahap seleksi, silahkan tekan tombol dibawah ini untuk mengirim ulang';
          break;
        default:
          result = '';
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GlobalHeader(
              isMain: true,
            ),
            Expanded(
              child: authData != null ?
              authData!.status == 'active' ?
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: mainMenu.length,
                itemBuilder: (BuildContext gridContext, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0,),
                    child: HomeMainMenu(
                      mainMenu: mainMenu[index],
                    ),
                  );
                },
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const GlobalText(
                        content: 'Status Akun: ',
                        align: TextAlign.center,
                        size: 16.0,
                      ),
                      GlobalText(
                        content: authData!.status == 'on-review' ? 'Sedang di Seleksi' : authData!.status == 'rejected' ? 'Ditolak' : 'Belum Aktif',
                        color: authData!.status == 'on-review' ? GlobalColor.defaultBlue : GlobalColor.defaultRed,
                        isBold: true,
                        size: 20.0,
                      ),
                    ],
                  ),
                  GlobalText(
                    content: textLoad(),
                    align: TextAlign.center,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 15.0,
                      paddingTop: 15.0,
                      paddingRight: 15.0,
                      paddingBottom: 15.0,
                    ),
                  ),
                  authData!.status != 'on-review' ?
                  GlobalElevatedButton(
                    onPressed: () async {
                      await UserServices().updateUserStatus(
                        AuthData(
                          userId: authData!.userId,
                          status: 'on-review',
                        ),
                      ).then((result) async {
                        if(result) {
                          await SharedPref().writeAuthorization(
                            AuthData(
                              userId: authData!.userId,
                              email: authData!.email,
                              password: authData!.password,
                              name: authData!.name,
                              phone: authData!.phone,
                              address: authData!.address,
                              role: authData!.role,
                              status: 'on-review',
                            ),
                          ).then((writeAuth) {
                            if(writeAuth) {
                              initLoad();
                            }
                          });
                        }
                      });
                    },
                    title: authData!.status != 'rejected' ? 'Ikuti Seleksi' : 'Kirim Ulang',
                  ) :
                  const Material(),
                ],
              ) :
              const Material(),
            ),
            GlobalElevatedButton(
              onPressed: () {
                GlobalDialog(context: context, message: 'Keluar dari sesi saat ini, Anda yakin?').optionDialog(() async {
                  await SharedPref().deleteAuthorization().then((result) {
                    GlobalRoute(context: context).replaceWith(const SplashScreen());
                  });
                }, () {

                });
              },
              title: 'Keluar',
              padding: const GlobalPaddingClass(
                paddingLeft: 60.0,
                paddingRight: 60.0,
                paddingBottom: 20.0,
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