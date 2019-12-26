/// ClientModel.dart
import 'dart:convert';

History historyFromJson(String str) {
  final jsonData = json.decode(str);
  return History.fromMap(jsonData);
}

String historyToJson(History data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class History {
  int id;
  String nama;
  String namaBarang;
  int jumlahBeli;
  int harga;
  int bayar;
  History({
    this.id,
    this.nama,
    this.namaBarang,
    this.jumlahBeli,
    this.harga,
    this.bayar,
  });

  factory History.fromMap(Map<String, dynamic> json) => new History(
        id: json["id"],
        nama: json["nama"],
        namaBarang: json["nama_barang"],
        jumlahBeli: json["jumlah_beli"],
        harga: json["harga"],
        bayar: json["bayar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "nama_barang": namaBarang,
        "jumlah_beli": jumlahBeli,
        "harga": harga,
        "bayar": bayar,
      };
}
