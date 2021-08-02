import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/User/widgets/custon_text.dart';
import 'package:my_second_ecomerce_app/provider/category_provider.dart';
import 'package:my_second_ecomerce_app/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/User/screens/category.dart';
import 'package:my_second_ecomerce_app/User/widgets/categorie_widget.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:provider/provider.dart';

class MyCategorie extends StatelessWidget {
  const MyCategorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<UserProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Category",
          color: black,
        ),
        backgroundColor: white.withOpacity(0.2),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categoryProvider.category.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
//                              app.changeLoading();
                    await productProvider.loadCategory(
                        categoryName: categoryProvider.category[index].name);

                    pushScreen(
                        context,
                        CategoryScreen(
                          categoryModel: categoryProvider.category[index],
                        ));

//                              app.changeLoading();
                  },
                  child: CategoryWidget(
                    category: categoryProvider.category[index],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
