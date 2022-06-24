import 'package:flutter/material.dart';
import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';
import 'package:siqurol_app/miscellaneous/variables/global_color.dart';
import 'package:siqurol_app/services/local_db.dart';
import 'package:siqurol_app/widgets/global_padding.dart';
import 'package:siqurol_app/widgets/global_text.dart';
import 'package:siqurol_app/widgets/global_header.dart';

class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({Key? key}) : super(key: key);

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
  List<AuthData> participantList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await LocalDB().readOnlyUserRole().then((user) {
      setState(() {
        participantList = user;
      });
    });
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
                    child: ListTile(
                      title: GlobalText(
                        content: participantList[index].name ?? 'Unknown Name',
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
                              content: participantList[index].email ?? 'Unknown Email',
                            ),
                            GlobalText(
                              content: participantList[index].phone ?? 'Unknown Phone',
                            ),
                            GlobalText(
                              content: participantList[index].address ?? 'Unknown Address',
                            ),
                          ],
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