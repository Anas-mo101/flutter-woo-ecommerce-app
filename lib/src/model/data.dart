import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/modules/product/model/product.dart';

class AppData {
  static List<Product> productList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now",
        desc: "Product Desc",
        rating: 4,
        availableSColor: [
          'red',
          'black'
        ],
        availableSizes: [
          'S',
          'L',
          'XL'
        ]
    ),
    Product(
        id: 3,
        name: 'Nike Water Min 45700',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now",
        desc: "Product Desc",
        rating: 4,
        availableSColor: [
          'black',
          'white'
        ],
        availableSizes: [
          'XS',
          'L',
          '4XL'
        ]
    ),
  ];


  static List<Category> categoryList = [
    Category(),
    Category( id: 1, name: "Sneakers", image: 'assets/shoe_thumb_2.png', isSelected: true),
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