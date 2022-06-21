class ScheduleData {
  String scheduleId;
  DateTime date;
  String hour;
  String speaker;
  int capacity;

  ScheduleData({
    required this.scheduleId,
    required this.date,
    required this.hour,
    required this.speaker,
    required this.capacity,
  });
}