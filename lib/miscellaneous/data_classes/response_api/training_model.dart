class TrainingResponseAPI {
  int? status;
  String? message;
  List<TrainingDataAPI>? data;

  TrainingResponseAPI({this.status, this.message, this.data});

  TrainingResponseAPI.fromJson(Map<String, dynamic> json) {
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

class TrainingParticipantResponseAPI {
  int? status;
  String? message;
  List<TrainingParticipantDataAPI>? data;

  TrainingParticipantResponseAPI({this.status, this.message, this.data});

  TrainingParticipantResponseAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrainingParticipantDataAPI>[];
      json['data'].forEach((v) {
        data!.add(TrainingParticipantDataAPI.fromJson(v));
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

class TrainingParticipantDataAPI {
  String? id;
  String? nama;
  String? email;
  String? statusSertifikat;

  TrainingParticipantDataAPI({this.id, this.nama, this.email, this.statusSertifikat});

  TrainingParticipantDataAPI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    statusSertifikat = json['status_sertifikat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['email'] = email;
    data['status_sertifikat'] = statusSertifikat;
    return data;
  }
}