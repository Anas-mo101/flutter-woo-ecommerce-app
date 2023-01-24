import 'package:flutter/material.dart';
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

  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                CartController.addToCart(controller.product).then((value) => controller.setProductQtyInCart());
              },
              backgroundColor: LightColor.orange,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.shopping_cart, color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
                  ),
                  if(controller.productQtyInCart > 0)
                  Positioned(
                      top: 25,
                      left: 0,
                      child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black), child: Center(child: Text('${controller.productQtyInCart}'))))
                ],
              ),
            ),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfff1f0f0),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _appBar(context, controller.isLiked),
                        if(!controller.isLoading && (controller.product?.image != null && controller.product.image.isNotEmpty) )
                          _productImage(context, controller.product.image[controller.selectProductVariation]),
                      ],
                    ),
                    if(!controller.isLoading && controller?.product?.image != null)
                      Positioned(
                        top: 270,
                          child: _categoryWidget(
                            context,
                            controller.product.image,
                            controller.toggleProduct
                          )
                      ),
                    if(controller.isLoading)
                      Center(child: CircularProgressIndicator()),
                    if(!controller.isLoading)
                      _detailWidget(controller.product)
                  ],
                ),
              ),
            ),
          );
        }
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
            onPressed: () => Get.back(),
          ),
          _icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? LightColor.red : LightColor.lightGrey,
              size: 15,
              padding: 12,
              isOutLine: true,
              onPressed: () {

              }
          ),
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
      child: Center(child: Icon(icon, color: color, size: size)),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage(BuildContext context, String imgLink) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        TitleText(
          text: "AIP",
          fontSize: 160,
          color: LightColor.lightGrey,
        ),
        (imgLink == '' && imgLink == null) ?
          Image.asset('assets/show_1.png') : Image.network(imgLink)
      ],
    );
  }

  Widget _categoryWidget(BuildContext context, List<String> images, Function toggle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((x) =>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  width: 50,
                  child: Image.network(x.value,scale: 0.5),
                ).ripple(() => toggle(x.key), borderRadius: BorderRadius.all(Radius.circular(13))),
              )
          ).toList()
      ),
    );
  }

  Widget _detailWidget(Product product) {
    List<Widget> ratings = [];
    if(product?.rating != null){
      for (var i = 0; i < product.rating; i++) {
        ratings.add(Icon(Icons.star, color: LightColor.yellowColor, size: 17));
      }
    }

    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .58,
      minChildSize: .58,
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
                TitleText(text: product?.name ?? '...', fontSize: 25),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                              text: '${product?.price ?? '0.0'}',
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
                if (product?.availableSizes?.length != null && product.availableSizes.length > 0)
                SizedBox(
                  height: 20,
                ),
                if (product?.availableSizes?.length != null && product.availableSizes.length > 0)
                  _availableSize(product.availableSizes),
                if (product?.availableSColor != null && product.availableSColor.length > 0)
                SizedBox(
                  height: 20,
                ),
                if (product?.availableSColor != null && product.availableSColor.length > 0)
                  _availableColor(product.availableSColor),
                SizedBox(
                  height: 20,
                ),
                _description(product?.desc ?? '...'),
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
      if (productController.selectedAvailableSizes == element.key) {
        sizes.add(_sizeWidget(element.value, isSelected: true));
      } else {
        sizes.add(_sizeWidget(element.value));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "available_sizes".tr,
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[...sizes],
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
      if (productController.selectedAvailableSColor == element.key) {
        colors.add(_colorWidget(element.value, isSelected: true));
      } else {
        colors.add(_colorWidget(element.value));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: "available_colors".tr, fontSize: 14),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[...colors],
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
      onTap: () {
        productController.toggleColorOptions(c);
      },
      child: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color.withAlpha(150),
              child: isSelected ? Icon(Icons.check_circle, color: color, size: 18) : CircleAvatar(radius: 7, backgroundColor: color),
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
          text: "description".tr,
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(desc),
      ],
    );
  }

}
