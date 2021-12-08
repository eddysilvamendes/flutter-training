library product_details;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace_design/app/constans/app_constants.dart';
import 'package:marketplace_design/app/shared_components/custon_icon_button.dart';
import 'package:marketplace_design/app/shared_components/indicator.dart';
import 'package:marketplace_design/app/utils/services/rest_api_services.dart';
import 'package:marketplace_design/app/utils/ui/ui_utils.dart';

//bindigs
part '../../bindings/product_detail_binding.dart';

//controller
part '../../controllers/product_detail_controller.dart';

//components
part '../components/product_image.dart';
part '../components/back_button.dart';
part '../components/favorite_button.dart';
part '../components/share_button.dart';
part '../components/body_content.dart';
part '../components/price_text.dart';
part '../components/views_text.dart';
part '../components/name_text.dart';
part '../components/rating.dart';
part '../components/reviews_text.dart';
part '../components/description_text.dart';
part '../components/buy_button.dart';
part '../components/chat_button.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            (controller.data.value == null || controller.dataUser.value == null)
                ? Text("Product Not found")
                : _buildProductDetail(
                    product: controller.data.value!,
                    user: controller.dataUser.value!),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kSpacing / 2),
        child: Row(
          children: [
            SizedBox(width: kSpacing / 2),
            _ChatButton(onPressed: () {}),
            SizedBox(width: kSpacing),
            _BuyButton(onPressed: () {}),
            SizedBox(width: kSpacing / 2),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetail({required Product product, required User user}) {
    return Stack(
      children: [
        //Detail all Content
        SingleChildScrollView(
          controller: controller.scroll,
          child: Stack(
            children: [
              //BackGround Image
              Hero(tag: product.id, child: _ProductImage(product.images)),

              //Body COntent
              _BodyContent(
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: _PriceText(
                              product.price.toString(),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: _ViewsText(
                              "${product.totalViews} Views",
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: kSpacing),
                      _NameText(product.name),
                      SizedBox(height: kSpacing),
                      Row(
                        children: [
                          _Rating(product.rating),
                          SizedBox(width: kSpacing),
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          _ReviewsText("${product.totalReview} Reviews"),
                        ],
                      ),
                      SizedBox(height: kSpacing * 2),
                      _DescriptionText(product.description),
                      SizedBox(height: kSpacing),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.profilImage,
                          ),
                          title: Text(user.name),
                          subtitle: Text("${user.country} (${user.city})"),
                          trailing: Icon(Icons.keyboard_arrow_right_rounded),
                          onTap: () {
                            print("OK");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        //Header Button
        Obx(
          () => AnimatedOpacity(
            opacity: controller.opacityActionButton.value,
            duration: Duration(milliseconds: 200),
            child: Visibility(
              visible: controller.isVisibleActionButton.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 40,
                ),
                child: Row(
                  children: [
                    _BackButton(
                      onPressed: () => controller.back(),
                    ),
                    Spacer(),
                    _FavoriteButtom(
                      initial: product.isFavorite,
                      onChanged: (isFavorie) {
                        controller.changeFavoriteProduct(product, isFavorie);
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    _ShareButton(
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
