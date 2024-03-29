import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:get/get.dart';
import '../../../config/route.dart';
import '../../../config/woo_store/woo_store_service.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/product_card_loading.dart';
import '../../../widgets/related_product_card.dart';
import '../model/product.dart';
import '../controller/product_controller.dart';
import '../model/woo_product_review.dart';
import '../model/woocommerce_product.dart';

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
              onPressed: () => controller.addCurrentProductToCart(),
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

  List<Widget> _stars(int stars){
    List<Widget> ratings = [];
    for (var i = 0; i < stars; i++) {
      ratings.add(Icon(Icons.star, color: LightColor.yellowColor, size: 17));
    }
    return ratings;
  }

  Widget _detailWidget(Product product) {
    List<Widget> ratings = [];
    if(product?.rating != null){
      for (var i = 0; i < product.rating; i++) {
        ratings.add(Icon(Icons.star, color: LightColor.yellowColor, size: 17));
      }
    }

    final currencyCode = Get.find<WooStoreService>().storeCurrency.code ?? '\$';

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
                              text: "$currencyCode ",
                              fontSize: 18,
                              color: LightColor.red,
                            ),
                            TitleText(
                              text: productController.getProductPrices(),
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
                if(product?.desc != null && product.desc != '')
                  _description(product.desc),
                productController.isRelatedProductsLoading ? Container(padding: EdgeInsets.symmetric(vertical: 50), child: Center(child: CircularProgressIndicator())) :
                  _relatedProducts(productController.relatedProducts),
                productController.isReviewsLoading ? Container(padding: EdgeInsets.symmetric(vertical: 50), child: Center(child: CircularProgressIndicator())) :
                _reviews(productController.productReviews),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _relatedProducts(List<Product> products){
    if(products.isEmpty){
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        TitleText(
          text: "Related Products",
          fontSize: 14,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: AppTheme.fullWidth(Get.context),
          height: AppTheme.fullWidth(Get.context)/1.5,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 3,
                mainAxisSpacing: 30.0,
                crossAxisSpacing: 20.0
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: products.map( (product) => RelatedProductCard( product: product, onSelected: (model) {
                Get.toNamed(Routes.product, arguments: model.id);
            }),
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _reviews(List<WooProductReview> reviews){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          TitleText(
            text: "Reviews",
            fontSize: 14,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            constraints: BoxConstraints(
              minWidth: AppTheme.fullWidth(Get.context),
              maxWidth: AppTheme.fullWidth(Get.context),
              minHeight: reviews.isEmpty ? 100 : 200,
              maxHeight: reviews.isEmpty ? 100 : 200,
            ),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black)
            ),
            child: reviews.isEmpty ? Center(child: Text('No Reviews')) : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: 5 / 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 30.0
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: reviews.map(
                  (review) {
                    String reviewFormat = '${review.review.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').trim()}';
                    if(reviewFormat.length > 200){
                      reviewFormat = reviewFormat.substring(0, 200) + '...';
                    }
                    
                    return Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(review.reviewerAvatarUrls.s48),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${review.reviewer}'),
                                    Container(
                                      child: Row(
                                        children: [
                                          ..._stars(review.rating.toInt()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${review.review.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').trim()}'),
                                  Text('${productController.getDurationAgo(review.dateCreated)}'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
              ).toList(),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: LightColor.orange,
              width: AppTheme.fullWidth(Get.context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Review ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.comment,color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      );
  }

  Widget _availableSize(List<WooAttributes> availableSizes) {
    List<Widget> sizes = [];
    availableSizes.forEach((e) {
      for (var element in e.options.asMap().entries) {
        if (productController.selectedAvailableSizes == element.key) {
          sizes.add(_sizeWidget(element.value, isSelected: true));
        } else {
          sizes.add(_sizeWidget(element.value));
        }
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "available_sizes".tr,
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Container(
            height: 50,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return sizes[index];
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 20);
                },
                itemCount: sizes.length
            )
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

  Widget _availableColor(List<WooAttributes> availableColors) {
    List<Widget> colors = [];
    availableColors.forEach((e) {
      for (var element in e.options.asMap().entries) {
        if (productController.selectedAvailableColor == element.key) {
          colors.add(_colorWidget(element.value, isSelected: true));
        } else {
          colors.add(_colorWidget(element.value));
        }
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: "available_colors".tr, fontSize: 14),
        SizedBox(height: 20),
        Container(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return colors[index];
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 20);
              },
              itemCount: colors.length
          )
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
      case 'Blue':
        color = Colors.blue;
        break;
      case 'Black':
        color = Colors.black;
        break;
      case 'White':
        color = Colors.white54;
        break;
      case 'Yellow':
        color = Colors.yellow;
        break;
      case 'Red':
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
              radius: 20,
              backgroundColor: color.withAlpha(150),
              child: isSelected ?
                Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 25
                ) :
                CircleAvatar(
                    radius: 7,
                    backgroundColor: color
                ),
            ),
            SizedBox(
              width: 50,
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
