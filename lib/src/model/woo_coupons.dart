class WooCoupons {
  int id;
  String code;
  String amount;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String discountType;
  String description;
  String dateExpires;
  String dateExpiresGmt;
  int usageCount;
  bool individualUse;
  List<int> productIds;
  List<int> excludedProductIds;
  bool freeShipping;
  List<int> productCategories;
  List<int> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;

  WooCoupons(
      {this.id,
        this.code,
        this.amount,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.discountType,
        this.description,
        this.dateExpires,
        this.dateExpiresGmt,
        this.usageCount,
        this.individualUse,
        this.productIds,
        this.excludedProductIds,
        this.freeShipping,
        this.productCategories,
        this.excludedProductCategories,
        this.excludeSaleItems,
        this.minimumAmount,
        this.maximumAmount});

  WooCoupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountType = json['discount_type'];
    description = json['description'];
    dateExpires = json['date_expires'];
    dateExpiresGmt = json['date_expires_gmt'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    productIds = json['product_ids'].cast<int>();
    excludedProductIds = json['excluded_product_ids'].cast<int>();
    freeShipping = json['free_shipping'];
    productCategories = json['product_categories'].cast<int>();
    excludedProductCategories = json['excluded_product_categories'].cast<int>();
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['date_expires'] = this.dateExpires;
    data['date_expires_gmt'] = this.dateExpiresGmt;
    data['usage_count'] = this.usageCount;
    data['individual_use'] = this.individualUse;
    data['product_ids'] = this.productIds;
    data['excluded_product_ids'] = this.excludedProductIds;
    data['free_shipping'] = this.freeShipping;
    data['product_categories'] = this.productCategories;
    data['excluded_product_categories'] = this.excludedProductCategories;
    data['exclude_sale_items'] = this.excludeSaleItems;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    return data;
  }
}
