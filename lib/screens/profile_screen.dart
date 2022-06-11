import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/functions/global_route.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/header_widgets.dart';
import 'package:siqurol_app/widgets/profile_screen_widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController userAccount = TextEditingController(text: 'Dika');
  TextEditingController emailAccount = TextEditingController(text: 'dika@gmail.com');
  TextEditingController phoneAccount = TextEditingController(text: '0856612645');
  TextEditingController addressAccount = TextEditingController(text: 'Bogor');

  List profileItemList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      profileItemList = [
        ['Nomor Handphone', phoneAccount.text],
        ['Alamat', addressAccount.text],
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
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10.0,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0,),
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Image.asset(
                                '${GlobalString.assetImagePath}/profile_icon.png',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                content: userAccount.text,
                                size: 24.0,
                                color: GlobalColor.defaultBlue,
                                isBold: true,
                              ),
                              GlobalText(
                                content: emailAccount.text,
                                size: 16.0,
                                color: GlobalColor.defaultBlue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0,),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileItemList.length,
                      itemBuilder: (BuildContext profileItemContext, int index) {
                        return ProfileItem(
                          leadTitle: profileItemList[index][0],
                          content: profileItemList[index][1],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: GlobalElevatedButton(
                      onPressed: () {

                      },
                      title: 'Edit Profile',
                      padding: const GlobalPaddingClass(
                        paddingTop: 20.0,
                        paddingBottom: 10.0,
                      ),
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