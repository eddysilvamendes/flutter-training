//Function that return a list of category model

import 'package:freepaper/model/categoryModel.dart';

String apiKey = "563492ad6f91700001000001a7f20b6b5b9b4b53be8247fefbfb475e";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categorieModel = CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Street Art";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Wild Life";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Nature";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "City";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categorieModel.categorieName = "Motivation";

  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Bikes";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Cars";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/574071/pexels-photo-574071.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Coding";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //1
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/4065880/pexels-photo-4065880.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Love";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //2
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/5894435/pexels-photo-5894435.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Soccer";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //3
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/707582/pexels-photo-707582.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Time";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //4
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/21696/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Motivational";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //5
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/90319/pexels-photo-90319.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categorieModel.categorieName = "Bedroom";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //6
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/3031754/pexels-photo-3031754.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categorieModel.categorieName = "Black";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //7
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/2581922/pexels-photo-2581922.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  categorieModel.categorieName = "House";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //8
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/4503267/pexels-photo-4503267.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categorieModel.categorieName = "Gardening";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //9
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/777001/pexels-photo-777001.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categorieModel.categorieName = "Desktop";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();

  //6
  categorieModel.imgUrl =
  "https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  categorieModel.categorieName = "Landscape";
  categories.add(categorieModel);
  categorieModel = new CategoryModel();



  return categories;

}

