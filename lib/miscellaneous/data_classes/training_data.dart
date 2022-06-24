import 'package:flutter/material.dart';

class TrainingData {
  int? scheduleId;
  DateTime? date;
  TimeOfDay? hour;
  String? speaker;
  int? numberOfParticipant;

  TrainingData({
    this.scheduleId,
    this.date,
    this.hour,
    this.speaker,
    this.numberOfParticipant,
  });
}