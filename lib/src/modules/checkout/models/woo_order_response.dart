

class WooOrderResponse {
  int id;
  int parentId;
  String number;
  String orderKey;
  String createdVia;
  String version;
  String status;
  String currency;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  bool pricesIncludeTax;
  int customerId;
  String customerIpAddress;
  String customerUserAgent;
  String customerNote;
  BillingResponse billing;
  ShippingResponse shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String datePaid;
  String datePaidGmt;
  Null dateCompleted;
  Null dateCompletedGmt;
  String cartHash;
  List<MetaData> metaData;
  List<LineItemsResponse> lineItems;
  List<TaxLines> taxLines;
  List<ShippingLinesResponse> shippingLines;

  WooOrderResponse(
      {this.id,
        this.parentId,
        this.number,
        this.orderKey,
        this.createdVia,
        this.version,
        this.status,
        this.currency,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.discountTotal,
        this.discountTax,
        this.shippingTotal,
        this.shippingTax,
        this.cartTax,
        this.total,
        this.totalTax,
        this.pricesIncludeTax,
        this.customerId,
        this.customerIpAddress,
        this.customerUserAgent,
        this.customerNote,
        this.billing,
        this.shipping,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.transactionId,
        this.datePaid,
        this.datePaidGmt,
        this.dateCompleted,
        this.dateCompletedGmt,
        this.cartHash,
        this.metaData,
        this.lineItems,
        this.taxLines,
        this.shippingLines});

  WooOrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    number = json['number'];
    orderKey = json['order_key'];
    createdVia = json['created_via'];
    version = json['version'];
    status = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    pricesIncludeTax = json['prices_include_tax'];
    customerId = json['customer_id'];
    customerIpAddress = json['customer_ip_address'];
    customerUserAgent = json['customer_user_agent'];
    customerNote = json['customer_note'];
    billing =
    json['billing'] != null ? new BillingResponse.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ?
         new ShippingResponse.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    datePaid = json['date_paid'];
    datePaidGmt = json['date_paid_gmt'];
    dateCompleted = json['date_completed'];
    dateCompletedGmt = json['date_completed_gmt'];
    cartHash = json['cart_hash'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
    if (json['line_items'] != null) {
      lineItems = <LineItemsResponse>[];
      json['line_items'].forEach((v) {
        lineItems.add(new LineItemsResponse.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = <TaxLines>[];
      json['tax_lines'].forEach((v) {
        taxLines.add(new TaxLines.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLinesResponse>[];
      json['shipping_lines'].forEach((v) {
        shippingLines.add(new ShippingLinesResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['number'] = this.number;
    data['order_key'] = this.orderKey;
    data['created_via'] = this.createdVia;
    data['version'] = this.version;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_total'] = this.discountTotal;
    data['discount_tax'] = this.discountTax;
    data['shipping_total'] = this.shippingTotal;
    data['shipping_tax'] = this.shippingTax;
    data['cart_tax'] = this.cartTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['prices_include_tax'] = this.pricesIncludeTax;
    data['customer_id'] = this.customerId;
    data['customer_ip_address'] = this.customerIpAddress;
    data['customer_user_agent'] = this.customerUserAgent;
    data['customer_note'] = this.customerNote;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['transaction_id'] = this.transactionId;
    data['date_paid'] = this.datePaid;
    data['date_paid_gmt'] = this.datePaidGmt;
    data['date_completed'] = this.dateCompleted;
    data['date_completed_gmt'] = this.dateCompletedGmt;
    data['cart_hash'] = this.cartHash;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    if (this.taxLines != null) {
      data['tax_lines'] = this.taxLines.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillingResponse {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  BillingResponse(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country,
        this.email,
        this.phone});

  BillingResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class ShippingResponse {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  ShippingResponse(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country});

  ShippingResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }
}

class MetaData {
  int id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class LineItemsResponse {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<TaxesResponse> taxes;
  String sku;
  double price;
  List<MetaData> metaData;

  LineItemsResponse(
      {this.id,
        this.name,
        this.productId,
        this.variationId,
        this.quantity,
        this.taxClass,
        this.subtotal,
        this.subtotalTax,
        this.total,
        this.totalTax,
        this.taxes,
        this.sku,
        this.price,
        this.metaData});

  LineItemsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    if (json['taxes'] != null) {
      taxes = <TaxesResponse>[];
      json['taxes'].forEach((v) {
        taxes.add(new TaxesResponse.fromJson(v));
      });
    }
    sku = json['sku'];
    price = json['price'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['quantity'] = this.quantity;
    data['tax_class'] = this.taxClass;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
    }
    data['sku'] = this.sku;
    data['price'] = this.price;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxesResponse {
  int id;
  String total;
  String subtotal;

  TaxesResponse({this.id, this.total, this.subtotal});

  TaxesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class TaxLines {
  int id;
  String rateCode;
  int rateId;
  String label;
  bool compound;
  String taxTotal;
  String shippingTaxTotal;

  TaxLines(
      {this.id,
        this.rateCode,
        this.rateId,
        this.label,
        this.compound,
        this.taxTotal,
        this.shippingTaxTotal});

  TaxLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateCode = json['rate_code'];
    rateId = json['rate_id'];
    label = json['label'];
    compound = json['compound'];
    taxTotal = json['tax_total'];
    shippingTaxTotal = json['shipping_tax_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate_code'] = this.rateCode;
    data['rate_id'] = this.rateId;
    data['label'] = this.label;
    data['compound'] = this.compound;
    data['tax_total'] = this.taxTotal;
    data['shipping_tax_total'] = this.shippingTaxTotal;
    return data;
  }
}

class ShippingLinesResponse {
  int id;
  String methodTitle;
  String methodId;
  String total;
  String totalTax;

  ShippingLinesResponse(
      {this.id, this.methodTitle, this.methodId, this.total, this.totalTax});

  ShippingLinesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_title'] = this.methodTitle;
    data['method_id'] = this.methodId;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}
