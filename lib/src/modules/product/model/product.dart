class Product {
  int id;
  String name;
  String desc;
  String category;
  String image;
  double price;

  bool isliked;
  bool isSelected;

  List<String> availableSizes = [];
  List<String> availableSColor = [];

  int rating = 0;
  int quantity = 0;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
      rating: json['price'].toInt(),
      isliked: json['isliked'],
      isSelected: json['isSelected'],
      availableSizes: json['availableSizes'].cast<String>(),
      availableSColor: json['availableSColor'].cast<String>(),
    );
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
