import 'dart:convert';
import 'package:flutter_ecommerce_app/src/modules/product/model/woocommerce_product.dart';

class Product {
  int id;
  String name;
  String desc;
  String category;
  List<String> image;
  double price;

  bool isliked;
  bool isSelected;

  List<WooAttributes> availableSizes = [];
  List<WooAttributes> availableSColor = [];

  int rating = 0;
  int quantity = 0;

  WooAttributes selectedSize;
  WooAttributes selectedColor;

  Product({
    this.id,
    this.name,
    this.category,
    this.price,
    this.isliked,
    this.isSelected = false,
    this.image,
    this.desc,
    this.availableSColor,
    this.availableSizes,
    this.rating,
    this.quantity = 0,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    category = json['category'];
    image = json['image'].cast<String>();
    price = json['price'].toDouble();
    rating = json['price'].toInt();
    isliked = json['isliked'];
    isSelected = json['isSelected'];

    if (json['availableSizes'] != null) {
      availableSizes = <WooAttributes>[];
      json['availableSizes'].forEach((v) {
        availableSizes.add(new WooAttributes.fromJson(v));
      });
    }

    if (json['availableSColor'] != null) {
      availableSColor = <WooAttributes>[];
      json['availableSColor'].forEach((v) {
        availableSColor.add(new WooAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['category'] = this.category;
    data['image'] = this.image;
    data['price'] = this.price;
    data['isliked'] = this.isliked;
    data['isSelected'] = this.isSelected;
    data['availableSizes'] = this.availableSizes;
    data['availableSColor'] = this.availableSColor;
    data['rating'] = this.rating;
    return data;
  }
}
