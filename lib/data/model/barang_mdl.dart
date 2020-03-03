class Barang {
  String status;
  String message;
  List<Data> data;

  Barang({this.status, this.message, this.data});

  Barang.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String namaBarang;
  String jumlah;
  String idUser;
  String create;

  Data({this.id, this.namaBarang, this.jumlah, this.idUser, this.create});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBarang = json['nama_barang'];
    jumlah = json['jumlah'];
    idUser = json['id_user'];
    create = json['create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_barang'] = this.namaBarang;
    data['jumlah'] = this.jumlah;
    data['id_user'] = this.idUser;
    data['create'] = this.create;
    return data;
  }
}
