import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

import '../modules/profile/models/user.dart';

class AppData {
  static User user = User(
      'Anas Mohamed',
      '12345',
      'anas@gmail.com'
  );

  // static List<Product> productList = [
  //   Product(
  //       id: 30,
  //       name: 'Nike Air Max 200',
  //       price: 240.00,
  //       isSelected: true,
  //       isliked: false,
  //       image: ['assets/shooe_tilt_1.png'],
  //       category: "Trending Now",
  //       desc: "Product Desc",
  //       rating: 4,
  //       availableSColor: [
  //         'red',
  //         'black'
  //       ],
  //       availableSizes: [
  //         'S',
  //         'L',
  //         'XL'
  //       ]
  //   ),
  // ];


  static List<Category> categoryList = [
    Category(id: 4, name: "All", image: '', isSelected: true),
    Category( id: 1, name: "Sneakers", image: 'assets/shoe_thumb_2.png'),
    Category(id: 2, name: "Jacket", image: 'assets/jacket.png'),
    Category(id: 3, name: "Watch", image: 'assets/watch.png'),
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}