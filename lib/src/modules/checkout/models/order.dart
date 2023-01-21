import '../../product/model/product.dart';

class Order{
  Map<int, int> itemsQty = {};
  List<Product> uniqueList = [];

  String paymentOption;

  double subtotal = 0.0;
  double tax = 0.0;
  double delv = 0.0;
  double total = 0.0;

  String customerName;
  String customerEmail;
  String customerPhone;
  String customerBillingAddress;
  String customerShippingAddress;
  String customerZipAddress;
  String customerCountry;

  Order(
      this.itemsQty,
      this.uniqueList,
      this.paymentOption,
      this.customerName,

      this.customerEmail,
      this.customerPhone,
      this.customerBillingAddress,
      this.customerShippingAddress,

      this.customerZipAddress,
      this.customerCountry,
  );


}