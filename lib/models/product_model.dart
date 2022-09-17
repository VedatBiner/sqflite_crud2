import '../models/model.dart';

class ProductModel extends Model {
  static String table = "products";

  int? id;
  int? categoryId;
  String productName;
  String? productDesc;
  double? price;
  String? productPic;

  // constructor
  ProductModel({
    id,
    required this.categoryId,
    required this.productName,
    this.productDesc,
    this.price,
    this.productPic
  });

  // ürün modeli
  static ProductModel fromMap(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      productName: json['productNme'].toString(),
      categoryId: json['categoryId'],
      productDesc: json['productDesc'].toString(),
      price: json['price'],
      productPic: json['productPic'],
    );
  }

  @override
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'id' : id,
      'productName' : productName,
      'categoryId' : categoryId,
      'price' : price,
      'productPic' : productPic,
    };
    if (id != null){
      map['id'] = id;
    }
    return map;
  }
}











