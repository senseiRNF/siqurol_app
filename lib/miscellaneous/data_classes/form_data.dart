class FormData {
  String participantName;
  String instanceName;
  String workshopPlace;
  DateTime? workshopDate;

  FormData({
    required this.participantName,
    required this.instanceName,
    required this.workshopPlace,
    this.workshopDate,
  });
}