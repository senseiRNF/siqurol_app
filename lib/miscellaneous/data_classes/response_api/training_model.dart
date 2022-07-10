class TrainingModelAPI {
  int? status;
  String? message;
  List<TrainingDataAPI>? data;

  TrainingModelAPI({this.status, this.message, this.data});

  TrainingModelAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrainingDataAPI>[];
      json['data'].forEach((v) {
        data!.add(TrainingDataAPI.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrainingDataAPI {
  String? id;
  String? tanggal;
  String? jam;
  String? pembicara;

  TrainingDataAPI({this.id, this.tanggal, this.jam, this.pembicara});

  TrainingDataAPI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    pembicara = json['pembicara'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tanggal'] = tanggal;
    data['jam'] = jam;
    data['pembicara'] = pembicara;
    return data;
  }
}