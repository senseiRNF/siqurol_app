import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/main_menu.dart';
import 'package:siqurol_app/miscellaneous/functions/global_dialog.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/screens/certificate_screen.dart';
import 'package:siqurol_app/screens/form_screen.dart';
import 'package:siqurol_app/screens/profile_screen.dart';
import 'package:siqurol_app/screens/schedule_screen.dart';
import 'package:siqurol_app/screens/splash_screen.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';
import 'package:siqurol_app/widgets/home_screen_widgets/home_main_menu.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;

  const HomeScreen({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MainMenuClasses> mainMenu = [];

  @override
  void initState() {
    super.initState();

    if(widget.isAdmin) {
      setState(() {
        mainMenu = [
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/profile_icon.png',
            title: 'Profil',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ProfileScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/participant_icon.png',
            title: 'Data Peserta',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ParticipantScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/schedule_icon.png',
            title: 'Jadwal Peserta',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ParticipantScheduleScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/certificate_icon.png',
            title: 'Sertifikat Peserta',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ParticipantCertificateScreen(), (callback) {

              });
            },
          ),
        ];
      });
    } else {
      setState(() {
        mainMenu = [
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/profile_icon.png',
            title: 'Profil',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ProfileScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/form_icon.png',
            title: 'Formulir',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const FormScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/schedule_icon.png',
            title: 'Jadwal',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const ScheduleScreen(), (callback) {

              });
            },
          ),
          MainMenuClasses(
            imagePath: '${GlobalString.assetImagePath}/certificate_icon.png',
            title: 'Sertifikat',
            onPressed: () {
              GlobalRoute(context: context).moveTo(const CertificateScreen(), (callback) {

              });
            },
          ),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MainHeader(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  ),
                ],
              ),
            ),
            GlobalElevatedButton(
              onPressed: () {
                GlobalDialog(context: context, message: 'Keluar dari sesi saat ini, Anda yakin?').optionDialog(() {
                  GlobalRoute(context: context).replaceWith(const SplashScreen());
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