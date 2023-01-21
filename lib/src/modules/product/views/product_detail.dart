import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../model/product.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/product_controller.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key key}) : super(key: key);

  final int productId = Get.arguments;
  final productController = Get.put(ProductController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: GetBuilder<ProductController>(
            init: ProductController(),
            builder: (controller) {
              controller.setProduct(productId);
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _appBar(context, controller.isLiked),
                      _productImage(context),
                      _categoryWidget(context),
                    ],
                  ),
                  _detailWidget(controller.product)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, bool isLiked) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? LightColor.red : LightColor.lightGrey, size: 15, padding: 12, isOutLine: false, onPressed: () {
            // setState(() {
            //   isLiked = !isLiked;
            // });
          }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = LightColor.iconColor,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: LightColor.iconColor, style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        // color: isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 5, spreadRadius: 10, offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        TitleText(
          text: "AIP",
          fontSize: 160,
          color: LightColor.lightGrey,
        ),
        Image.asset('assets/show_1.png')
      ],
    );
  }

  Widget _categoryWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
    );
  }

  Widget _thumbnail(String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 40,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: LightColor.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(13)),
          // color: Theme.of(context).backgroundColor,
        ),
        child: Image.asset(image),
      ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget _detailWidget(Product product) {
    List<Widget> ratings = [];
    for (var i = 0; i < product.rating; i++) {
      ratings.add(Icon(Icons.star, color: LightColor.yellowColor, size: 17));
    }

    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: LightColor.iconColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(text: product.name, fontSize: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: product.price.toString(),
                                fontSize: 25,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[...ratings],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(product.availableSizes.isNotEmpty)
                  _availableSize(product.availableSizes),
                SizedBox(
                  height: 20,
                ),
                if(product.availableSColor.isNotEmpty)
                _availableColor(product.availableSColor),
                SizedBox(
                  height: 20,
                ),
                _description(product.desc),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize(List availableSizes) {
    List<Widget> sizes = [];
    for (var element in availableSizes.asMap().entries) {
      if(productController.selectedAvailableSizes == element.key){
        sizes.add(_sizeWidget(element.value,isSelected: true));
      }else{
        sizes.add(_sizeWidget(element.value));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ...sizes
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: LightColor.iconColor, style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: isSelected ? LightColor.orange : Colors.white,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    ).ripple(() {
      productController.toggleSizeOptions(text);
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _availableColor(List availableColors) {
    List<Widget> colors = [];
    for (var element in availableColors.asMap().entries) {
      if(productController.selectedAvailableSColor == element.key){
        colors.add(_colorWidget(element.value,isSelected: true));
      }else{
        colors.add(_colorWidget(element.value));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText( text: "Available Colors", fontSize: 14),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ...colors
          ],
        )
      ],
    );
  }

  Widget _colorWidget(String c, {bool isSelected = false}) {
    Color color = Colors.white;

    switch (c) {
      case 'lightBlue':
        color = LightColor.lightBlue;
        break;
      case 'black':
        color = LightColor.black;
        break;
      case 'red':
        color = LightColor.red;
        break;
      case 'skyBlue':
        color = LightColor.skyBlue;
        break;
      default:
        color = Colors.white;
    }

    return InkWell(
      onTap: (){
        productController.toggleColorOptions(c);
      },
      child: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color.withAlpha(150),
              child: isSelected
                  ? Icon( Icons.check_circle, color: color, size: 18)
                  : CircleAvatar(radius: 7, backgroundColor: color),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _description(String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Description",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(desc),
      ],
    );
  }

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        CartController.addToCart(productController.product);
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket, color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }
}
