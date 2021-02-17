import 'dart:ui';

import 'package:flutter/material.dart';

class DVC_ThuTuc {
  int thuTucID;
  int linhVucID;
  String maLinhVuc;
  String tenLinhVuc;
  String maThuTuc;
  String tenThuTuc;
  String imageURL;
  Null moTaNgan;
  int thuTuThuTuc;
  int thuTuLinhVuc;
  bool isBanVe;
  int phanLoai;

  DVC_ThuTuc(
      {this.thuTucID,
      this.linhVucID,
      this.maLinhVuc,
      this.tenLinhVuc,
      this.maThuTuc,
      this.tenThuTuc,
      this.imageURL,
      this.moTaNgan,
      this.thuTuThuTuc,
      this.thuTuLinhVuc,
      this.isBanVe,
      this.phanLoai});

  DVC_ThuTuc.fromJson(Map<String, dynamic> json) {
    thuTucID = json['thuTucID'];
    linhVucID = json['linhVucID'];
    maLinhVuc = json['maLinhVuc'];
    tenLinhVuc = json['tenLinhVuc'];
    maThuTuc = json['maThuTuc'];
    tenThuTuc = json['tenThuTuc'];
    imageURL = json['imageURL'];
    moTaNgan = json['moTaNgan'];
    thuTuThuTuc = json['thuTu_ThuTuc'];
    thuTuLinhVuc = json['thuTu_LinhVuc'];
    isBanVe = json['isBanVe'];
    phanLoai = json['phanLoai'];
  }

  Map<String, String> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thuTucID'] = this.thuTucID;
    data['linhVucID'] = this.linhVucID;
    data['maLinhVuc'] = this.maLinhVuc;
    data['tenLinhVuc'] = this.tenLinhVuc;
    data['maThuTuc'] = this.maThuTuc;
    data['tenThuTuc'] = this.tenThuTuc;
    data['imageURL'] = this.imageURL;
    data['moTaNgan'] = this.moTaNgan;
    data['thuTu_ThuTuc'] = this.thuTuThuTuc;
    data['thuTu_LinhVuc'] = this.thuTuLinhVuc;
    data['isBanVe'] = this.isBanVe;
    data['phanLoai'] = this.phanLoai;
    return data;
  }
}

class DVC_LinhVuc {
  int linhVucID;
  String maLinhVuc;
  String tenLinhVuc;
  String tenLVRutGon;

  DVC_LinhVuc(
      {this.linhVucID, this.maLinhVuc, this.tenLinhVuc, this.tenLVRutGon});

  DVC_LinhVuc.fromJson(Map<String, dynamic> json) {
    linhVucID = json['linhVucID'];
    maLinhVuc = json['maLinhVuc'];
    tenLinhVuc = json['tenLinhVuc'];
    tenLVRutGon = json['tenLVRutGon'];
  }

  Map<String, String> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['linhVucID'] = this.linhVucID;
    data['maLinhVuc'] = this.maLinhVuc;
    data['tenLinhVuc'] = this.tenLinhVuc;
    data['tenLVRutGon'] = this.tenLVRutGon;
    return data;
  }
}

// ignore: camel_case_types
class DVC_ThuTuc_Detail {
  int thuTucID;
  String tenThuTuc;
  String maThuTuc;
  String moTa;
  List<Files> files;

  DVC_ThuTuc_Detail(
      {this.thuTucID, this.tenThuTuc, this.maThuTuc, this.moTa, this.files});

  DVC_ThuTuc_Detail.fromJson(Map<String, dynamic> json) {
    thuTucID = json['thuTucID'];
    tenThuTuc = json['tenThuTuc'];
    maThuTuc = json['maThuTuc'];
    moTa = json['moTa'];
    if (json['files'] != null) {
      files = new List<Files>();
      json['files'].forEach((v) {
        files.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thuTucID'] = this.thuTucID;
    data['tenThuTuc'] = this.tenThuTuc;
    data['maThuTuc'] = this.maThuTuc;
    data['moTa'] = this.moTa;
    if (this.files != null) {
      data['files'] = this.files.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int id;
  String maThuTuc;
  int fileID;
  String tenFile;
  Null gioiThieu;
  String templateMau;
  String templateTrong;
  Null moTaNgan;
  bool isBanVe;

  Files(
      {this.id,
        this.maThuTuc,
        this.fileID,
        this.tenFile,
        this.gioiThieu,
        this.templateMau,
        this.templateTrong,
        this.moTaNgan,
        this.isBanVe});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maThuTuc = json['maThuTuc'];
    fileID = json['fileID'];
    tenFile = json['tenFile'];
    gioiThieu = json['gioiThieu'];
    templateMau = json['template_Mau'];
    templateTrong = json['template_Trong'];
    moTaNgan = json['moTaNgan'];
    isBanVe = json['isBanVe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maThuTuc'] = this.maThuTuc;
    data['fileID'] = this.fileID;
    data['tenFile'] = this.tenFile;
    data['gioiThieu'] = this.gioiThieu;
    data['template_Mau'] = this.templateMau;
    data['template_Trong'] = this.templateTrong;
    data['moTaNgan'] = this.moTaNgan;
    data['isBanVe'] = this.isBanVe;
    return data;
  }
}
