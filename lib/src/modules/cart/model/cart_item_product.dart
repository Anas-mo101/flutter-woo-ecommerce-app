
class CartItemProduct {
  int id;
  String name;
  List<String> image;
  double price;
  int quantity;
  int variationId;
  String variationIdentifier;

  CartItemProduct({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity = 0,
    this.variationId = -1,
    this.variationIdentifier = '',
  });
}
