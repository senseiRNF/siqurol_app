import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/miscellaneous/variables/global_string.dart';
import 'package:siqurol_app/services/shared_preferences.dart';
import 'package:siqurol_app/widgets/global_button.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';
import 'package:siqurol_app/widgets/profile_screen_widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController userAccount = TextEditingController();
  TextEditingController emailAccount = TextEditingController();
  TextEditingController phoneAccount = TextEditingController();
  TextEditingController addressAccount = TextEditingController();

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((AuthData? auth) {
      if(auth != null) {
        setState(() {
          userAccount.text = auth.name;
          emailAccount.text = auth.email;
          phoneAccount.text = auth.phone;
          addressAccount.text = auth.address;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GlobalHeader(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0,),
                    child: ProfileItem(
                      leadTitle: 'Nama',
                      content: userAccount.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0,),
                    child: ProfileItem(
                      leadTitle: 'Email',
                      content: emailAccount.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0,),
                    child: ProfileItem(
                      leadTitle: 'No. Telp',
                      content: phoneAccount.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0,),
                    child: ProfileItem(
                      leadTitle: 'Alamat',
                      content: addressAccount.text,
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