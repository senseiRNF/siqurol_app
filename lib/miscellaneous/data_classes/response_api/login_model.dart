class LoginModelAPI {
  int? status;
  String? message;
  List<LoginDataAPI>? data;

  LoginModelAPI({this.status, this.message, this.data});

  LoginModelAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginDataAPI>[];
      json['data'].forEach((v) {
        data!.add(LoginDataAPI.fromJson(v));
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

class LoginDataAPI {
  String? id;
  String? nama;
  String? noTelp;
  String? alamat;
  String? email;
  String? pass;
  String? role;
  String? statusUser;

  LoginDataAPI({
    this.id,
    this.nama,
    this.noTelp,
    this.alamat,
    this.email,
    this.pass,
    this.role,
    this.statusUser,
  });

  LoginDataAPI.fromJson(Map<String, dynamic> json) {
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