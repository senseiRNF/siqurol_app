class FormData {
  String participantName;
  String instanceName;
  String trainingPlace;
  DateTime? trainingDate;

  FormData({
    required this.participantName,
    required this.instanceName,
    required this.trainingPlace,
    this.trainingDate,
  });
}