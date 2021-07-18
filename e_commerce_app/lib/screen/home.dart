import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_app/model/categoryicon.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/model/usermodel.dart';
import 'package:e_commerce_app/provider/category_provider.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/detailscreen.dart';
import 'package:e_commerce_app/screen/listproduct.dart';
import 'package:e_commerce_app/screen/searchcategory.dart';
import 'package:e_commerce_app/widgets/drawerscreen.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:e_commerce_app/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: non_constant_identifier_names
CategoryProvider category_provider;
// ignore: non_constant_identifier_names
ProductProvider productprovider;
Product menData;
Product ps5Data;
Product womenData;
Product ledData;
var featureSnapShot;
var newachivesSnapsot;
var shirt;
var dress;
var pant;
var shoes;
var tie;

class _HomePageState extends State<HomePage> {
  Widget _buildCategoryProduct({String image, int color}) {
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Color(color),
      child: Container(
        //height: 40,
        child: Image(
          image: NetworkImage(image),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      height: 250,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: [
          AssetImage("assets/images/camera.jpg"),
          AssetImage("assets/images/shopping.png"),
          AssetImage("assets/images/about.png"),
        ],
      ),
    );
  }

  Widget _buildDressIcon() {
    List<CategoryIcon> dressIcon = category_provider.getDressIconList;
    List<Product> dress = category_provider.getDressList;
    return Row(
        children: dressIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Dress",
                snapShot: dress,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image, color: 0xff33dcfd),
      );
    }).toList());
  }

  Widget _buildShirtIcon() {
    List<Product> shirts = category_provider.getShirtList;
    List<CategoryIcon> shirtIcon = category_provider.getshirtIconList;
    return Row(
        children: shirtIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Shirt",
                snapShot: shirts,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image, color: 0xfff38cdd),
      );
    }).toList());
  }

  Widget _buildShoeIcon() {
    List<CategoryIcon> shoeIcon = category_provider.getShoesIconList;
    List<Product> shoes = category_provider.getShoesList;
    return Row(
        children: shoeIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Shoes",
                snapShot: shoes,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xff4ff2af,
        ),
      );
    }).toList());
  }

  Widget _buildPantIcon() {
    List<CategoryIcon> pantIcon = category_provider.getPantIconList;
    List<Product> pant = category_provider.getPantList;
    return Row(
        children: pantIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Pant",
                snapShot: pant,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xff74acf7,
        ),
      );
    }).toList());
  }

  Widget _buildTieIcon() {
    List<CategoryIcon> tieIcon = category_provider.getTieIconList;
    List<Product> tie = category_provider.getTieList;
    return Row(
        children: tieIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Tie",
                snapShot: tie,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xfffc6c8d,
        ),
      );
    }).toList());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: <Widget>[
              _buildDressIcon(),
              _buildShirtIcon(),
              _buildShoeIcon(),
              _buildPantIcon(),
              _buildTieIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> homeFeactureProduct;
    List<Product> feature;
    homeFeactureProduct = productprovider.getHomeFeatureList;
    feature = productprovider.getFeatureList;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      snapShot: feature,
                      isCategory: false,
                    ),
                  ),
                );
              },
              child: Text(
                "View more",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: homeFeactureProduct.map(
            (e) {
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => DetailScreen(
                                image: e.image,
                                name: e.name,
                                price: e.price,
                              ),
                            ),
                          );
                        },
                        child: SingleProduct(
                            image: e.image, name: e.name, price: e.price),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              name: e.name,
                              price: e.price,
                              image: e.image,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                          name: e.name, price: e.price, image: e.image),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    List<Product> homeAchiveProduct;
    homeAchiveProduct = productprovider.getHomeAchiveList;
    List<Product> newachives = productprovider.getNewAchivesList;
    return Column(
      children: [
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Achives",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "New Achives",
                            snapShot: newachives,
                            isCategory: false,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
            children: homeAchiveProduct.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      image: e.image,
                                      price: e.price,
                                      name: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                  image: e.image, price: e.price, name: e.name),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    image: e.image,
                                    price: e.price,
                                    name: e.name,
                                  ),
                                ),
                              );
                            },
                            child: SingleProduct(
                                image: e.image, price: e.price, name: e.name),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void getCallAllFunction() {
    //---------------------------------------------------------------------
    //Get Category Data
    category_provider.getShirtData();
    category_provider.getDressData();
    category_provider.getShoesData();
    category_provider.getPantData();
    category_provider.getTieData();
    //------------------------------------------------------------------------
    //Get Product Data
    productprovider.getFeatureData();
    productprovider.getNewAchivesData();
    productprovider.getHomeFeatureData();
    productprovider.getHomeAchiveData();

    //-------------------------------------------------------------------
    //Get Category Icon Data

    category_provider.getShirtIconData();
    category_provider.getDressIconData();
    category_provider.getTieIconData();
    category_provider.getPantIconData();
    category_provider.getShoesIconData();

    //------------------------------------------------------------------------
    //Get User Data

    productprovider.getUserData();
  }

  Widget _buildMyDrawer() {
    List<UserModel> userModel = productprovider.getUserModelList;
    return Row(
        children: userModel.map((e) {
      return MyDrawer(
        userName: e.userName,
        userEmail: e.userEmail,
        userImage: e.userImage,
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    category_provider = Provider.of<CategoryProvider>(context);
    productprovider = Provider.of<ProductProvider>(context);
    getCallAllFunction();

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState.openDrawer();
          },
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: Search(),
          //     );
          //   },
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.black,
          //   ),
          // ),
          NotificationButton(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              //height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageCarousel(),
                  _buildCategory(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  _buildNewAchives(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
