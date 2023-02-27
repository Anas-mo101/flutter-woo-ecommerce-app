

class OrderTotals {
  double subtotal;
  double shippingTotal;
  double cartTax;
  double shippingTax;
  double taxTotal;
  double total;
  double taxRate;

  OrderTotals({
    this.subtotal,
    this.shippingTotal,
    this.cartTax,
    this.shippingTax,
    this.taxTotal,
    this.total,
    this.taxRate
  });

  OrderTotals.fromJson(Map<String, dynamic> json) {
    subtotal = checkDouble(json['subtotal']);
    shippingTotal = checkDouble(json['shipping_total']);
    cartTax = checkDouble(json['cart_tax']);
    shippingTax = checkDouble(json['shipping_tax']);
    taxTotal = checkDouble(json['tax_total']);
    total = checkDouble(json['total']);
    taxRate = checkDouble(json['tax_rate']);
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['shipping_total'] = this.shippingTotal;
    data['cart_tax'] = this.cartTax;
    data['shipping_tax'] = this.shippingTax;
    data['tax_total'] = this.taxTotal;
    data['total'] = this.total;
    data['tax_rate'] = this.taxRate;
    return data;
  }
}
