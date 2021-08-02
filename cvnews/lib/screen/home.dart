import 'package:cvnews/moduls/articleModel.dart';
import 'package:cvnews/moduls/categoryModel.dart';
import 'package:cvnews/screen/article.dart';
import 'package:cvnews/screen/category.dart';
import 'package:cvnews/screen/search.dart';
import 'package:cvnews/service/data.dart';
import 'package:cvnews/service/news.dart';
import 'package:cvnews/widget/custom.dart';
import 'package:cvnews/widget/loading.dart';
import 'package:cvnews/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> article = <ArticleModel>[];
  bool _loading =true;

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    article = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategory();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body:_loading? Loading() : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/15
              ),
              search("Search", (){
                pushScreen(context, SearchScreen(search: searchController.text));
              }, searchController),
              SizedBox(
                  height: 10
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true, //when use a listview inside a collum we need to use this shrinkwrap
                    itemBuilder: (context,i){
                    return CategoryTile(
                      imgUrl: categories[i].imgUrl,
                      categoryName: categories[i].categoryName,
                    );
                    }),
              ),
              Text("Top Headlines", textAlign: TextAlign.left,),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                //height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: article.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true, //when use a listview inside a collum we need to use this shrinkwrap
                    itemBuilder:(context, i){
                      return BlogTile(imgUrl: article[i].urlToImage,
                          title: article[i].title,
                          description: article[i].description,
                        url: article[i].articleUrl,
                      );
                    }),
              )
            ],
          ),
        ),
      )
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imgUrl, categoryName;

  const CategoryTile({Key? key, this.imgUrl, this.categoryName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pushScreen(context, CategoryScreen(category: categoryName.toLowerCase()));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(imgUrl, width: 100, height: 50, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black26
              ),
              child: Text(categoryName,style: TextStyle(color: white, fontWeight: FontWeight.w500, fontSize: 14,),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl, title, description, url;

  const BlogTile({Key? key, required this.imgUrl, required this.title, required this.description, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushScreen(context, ArticleScreen(url: url));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect
              (
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imgUrl,)),
            Text(title, style: TextStyle(
              fontSize: 17,
                  color: Colors.black87,
              fontWeight: FontWeight.w600

            ),),
            SizedBox(
              height: 8,
            ),
            Text(description,style: TextStyle(

            color: Colors.black54,)),
          ],
        ),
      ),
    );
  }
}
