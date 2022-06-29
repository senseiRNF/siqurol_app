import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';

class TrainingParticipantData {
  AuthData auth;
  bool isChecked;

  TrainingParticipantData({
    required this.auth,
    required this.isChecked,
  });
}