class CarModel {
  const CarModel({
    required this.carColor,
    required this.uId,
    required this.uniId,
    required this.carBrand,
    required this.carModel,
    required this.carNo,
  });
  final int carColor;
  final String uId;
  final String? uniId;
  final String carBrand;
  final String carModel;
  final String carNo;
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      carColor: json['carColor'],
      uId: json['uId'],
      carBrand: json['carBrand'],
      uniId: json['uniId'],
      carModel: json['carModel'],
      carNo: json['carNo'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'carBrand': carBrand,
      'carModel': carModel,
      'carColor': carColor,
      'uId': uId,
      'uniId': uniId,
      'carNo': carNo
    };
  }


}
