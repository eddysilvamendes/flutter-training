class DataModel {
  String brandname;
  String brandlogo;
  String price;
  int status;
  String discription;
  String brandIdNumber;
  //int brand_id_number;
  DataModel(
      {required this.brandlogo,
      required this.brandname,
      required this.price,
      required this.discription,
      required this.status,
      required this.brandIdNumber});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
      brandlogo:
          json["brand_logo"] == null ? "noimage.png" : json["brand_logo"],
      brandname: json["brand_name"],
      price: json["price"].toString(),
      discription: json["discription"],
      status: json["status"],
      brandIdNumber: json["brand_id_number"].toString());
}
