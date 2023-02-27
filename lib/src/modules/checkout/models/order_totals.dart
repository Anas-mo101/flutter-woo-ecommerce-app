

class OrderTotals {
  int subtotal;
  int shippingTotal;
  int cartTax;
  int shippingTax;
  int taxTotal;
  int total;

  OrderTotals(
      {this.subtotal,
        this.shippingTotal,
        this.cartTax,
        this.shippingTax,
        this.taxTotal,
        this.total});

  OrderTotals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shippingTotal = json['shipping_total'];
    cartTax = json['cart_tax'];
    shippingTax = json['shipping_tax'];
    taxTotal = json['tax_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['shipping_total'] = this.shippingTotal;
    data['cart_tax'] = this.cartTax;
    data['shipping_tax'] = this.shippingTax;
    data['tax_total'] = this.taxTotal;
    data['total'] = this.total;
    return data;
  }
}
