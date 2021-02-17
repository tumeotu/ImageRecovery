import 'package:flutter/cupertino.dart';
import 'package:image_recovery/utils/color_extends.dart';
import '../../../constants.dart';

class LoaiPhanAnhDM {
  final int loaiPhanAnhID;
  final String maLoaiPhanAnh;
  final String tenLoaiPhanAnh;
  final String moTa;
  final List<LoaiViPham> loaiViPhams;
  final String imagePhanAnh;
  final Gradient gradient;
  final bool isSelected;

  const LoaiPhanAnhDM(
      {@required this.loaiPhanAnhID,
      @required this.maLoaiPhanAnh,
      @required this.tenLoaiPhanAnh,
      this.moTa,
      this.loaiViPhams,
      this.isSelected,
      this.gradient,
      @required this.imagePhanAnh});

  LoaiPhanAnhDM itemSelectChanged(isSelectedChanged) {
    return LoaiPhanAnhDM(
        loaiPhanAnhID: this.loaiPhanAnhID,
        maLoaiPhanAnh: this.maLoaiPhanAnh,
        tenLoaiPhanAnh: this.tenLoaiPhanAnh,
        moTa: this.moTa,
        loaiViPhams: this.loaiViPhams,
        imagePhanAnh: this.imagePhanAnh,
        gradient: this.gradient,
        isSelected: isSelectedChanged);
  }

  factory LoaiPhanAnhDM.fromJson(Map<String, dynamic> json) {
    final listLoaiVP = json['loaiViPhams'] as List;
    final List<LoaiViPham> list = listLoaiVP.map((item) {
      return LoaiViPham.fromJson(item);
    }).toList();

    String imageLoaiViPham = cacvandekhac_phananh_image;
    Gradient gradientitem = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorExtends.fromHex("#f44545"),
          ColorExtends.fromHex("#f3ac2a")
        ]);
    final maLoaiPhanAnh = json['maLoaiPhanAnh'];
    switch (maLoaiPhanAnh) {
      case "VPTT":
        imageLoaiViPham = phananhdothi_phananh_image;
        break;
      case "HTDT":
        gradientitem = LinearGradient(
            begin: Alignment.centerLeft,
            end : Alignment.centerRight,
            colors: [
              ColorExtends.fromHex("#46c7ba"),
              ColorExtends.fromHex("#4b98ab")
            ]);
        imageLoaiViPham = hatangdothi_phananh_image;
        break;
      case "PAHS":
        gradientitem = LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              ColorExtends.fromHex("#4fc4dd"),
              ColorExtends.fromHex("#4184d3")
            ]);
        imageLoaiViPham = phananhhoso_phananh_image;
        break;
      case "ANTT":
        imageLoaiViPham = anninhtrattu_phananh_image;
        break;
    }

    return LoaiPhanAnhDM(
        loaiPhanAnhID: json['loaiPhanAnhID'],
        maLoaiPhanAnh: maLoaiPhanAnh,
        tenLoaiPhanAnh: json['tenLoaiPhanAnh'],
        moTa: json['moTa'],
        imagePhanAnh: imageLoaiViPham,
        gradient: gradientitem,
        loaiViPhams: list);
  }
}

class LoaiViPham {
  final int loaiViPhamID;
  final String maLoaiViPham;
  final String tenLoaiViPham;
  final String maLoaiPhanAnh;
  final String tenLoaiPhanAnh;

  const LoaiViPham(
      {@required this.loaiViPhamID,
      @required this.maLoaiViPham,
      @required this.tenLoaiViPham,
      @required this.maLoaiPhanAnh,
      @required this.tenLoaiPhanAnh});

  factory LoaiViPham.fromJson(Map<String, dynamic> json) => LoaiViPham(
      loaiViPhamID: json['loaiViPhamID'],
      maLoaiViPham: json['maLoaiViPham'],
      tenLoaiViPham: json['tenLoaiViPham']);
}
