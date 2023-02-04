import '../../product/model/product.dart';

class CartModel {
  int productId;
  int quantity;
  int variationId;
  Product product;
  List<String> variationIdentifier;

  CartModel(this.productId, this.quantity, this.product,{this.variationId, this.variationIdentifier});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    variationId = json['variation_id'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['variation_identifier'] != null) {
      variationIdentifier = <String>[];
      json['variation_identifier'].forEach((v) {
        variationIdentifier.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['variation_id'] = this.variationId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if(variationIdentifier != null){
      data['variation_identifier'] = this.variationIdentifier;
    }
    return data;
  }
}