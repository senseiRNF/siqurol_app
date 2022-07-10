class CreateUserResponseAPI {
  int? status;
  String? message;
  int? userId;

  CreateUserResponseAPI({this.status, this.message, this.userId});

  CreateUserResponseAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['user_id'] = userId;
    return data;
  }
}

class ReadUserResponseAPI {
  int? status;
  String? message;
  List<ReadUserDataAPI>? data;

  ReadUserResponseAPI({this.status, this.message, this.data});

  ReadUserResponseAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReadUserDataAPI>[];
      json['data'].forEach((v) {
        data!.add(ReadUserDataAPI.fromJson(v));
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

class ReadUserDataAPI {
  String? id;
  String? nama;
  String? noTelp;
  String? alamat;
  String? email;
  String? pass;
  String? role;
  String? statusUser;

  ReadUserDataAPI({
    this.id,
    this.nama,
    this.noTelp,
    this.alamat,
    this.email,
    this.pass,
    this.role,
    this.statusUser,
  });

  ReadUserDataAPI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    noTelp = json['no_telp'];
    alamat = json['alamat'];
    email = json['email'];
    pass = json['pass'];
    role = json['role'];
    statusUser = json['status_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['no_telp'] = noTelp;
    data['alamat'] = alamat;
    data['email'] = email;
    data['pass'] = pass;
    data['role'] = role;
    data['status_user'] = statusUser;
    return data;
  }
}