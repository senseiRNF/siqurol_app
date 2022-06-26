import 'package:siqurol_app/miscellaneous/data_classes/auth_data.dart';

class TrainingParticipantData {
  AuthData participant;
  bool isChecked;

  TrainingParticipantData({
    required this.participant,
    required this.isChecked,
  });
}