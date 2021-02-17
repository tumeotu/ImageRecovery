import 'package:flutter/cupertino.dart';

class MucDoHaiLong {
  final String tenLoai;
  final double soLuotDanhGia;
  final double haiLong;
  final bool isTong;
  final String uRLWeb;
  final String title;

  MucDoHaiLong(
      {this.tenLoai,
      this.soLuotDanhGia,
      this.haiLong,
      this.isTong,
      this.uRLWeb,
      this.title});

  factory MucDoHaiLong.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];

    return MucDoHaiLong(
        tenLoai: json['tenLoai'],
        soLuotDanhGia: json['soLuotDanhGia'],
        haiLong: json['haiLong'],
        isTong: json['isTong'],
        uRLWeb: json['uRLWeb'],
        title: json['title']);
  }
}

class ThongKeHoSo_Tong {
  final String tenLinhVuc;
  final double tiLeDungHan;
  final double tiLeTreHanLV;
  final int totalCount;

  ThongKeHoSo_Tong(
      {this.tenLinhVuc, this.tiLeDungHan, this.tiLeTreHanLV, this.totalCount});

  factory ThongKeHoSo_Tong.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];

    return ThongKeHoSo_Tong(
        tenLinhVuc: json['tenLinhVuc'],
        tiLeDungHan: json['tiLeDungHan'],
        tiLeTreHanLV: json['tiLeTreHanLV'],
        totalCount: json['totalCount']);
  }
}

class ThongKeHoSo_List {
  final int soLuongHoSo;
  final String tenLinhVuc;
  final double tiLe;

  ThongKeHoSo_List({this.soLuongHoSo, this.tenLinhVuc, this.tiLe});

  factory ThongKeHoSo_List.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return ThongKeHoSo_List(
        soLuongHoSo: json['soLuongHoSo'],
        tenLinhVuc: json['tenLinhVuc'],
        tiLe: json['tiLe']);
  }
}
