import 'package:cvnews/moduls/articleModel.dart';
import 'package:cvnews/screen/article.dart';
import 'package:cvnews/service/news.dart';
import 'package:cvnews/widget/custom.dart';
import 'package:cvnews/widget/loading.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ArticleModel> article = <ArticleModel>[];
  bool _loading =true;

  getCategoryNews() async{
    CategoryNews categoryNews = CategoryNews();
    await categoryNews.getCategoryNews(widget.category);
    article = categoryNews.categorynews;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: _loading ? Loading() : SingleChildScrollView(
        child: Container(
            child: Column(
              children: [
                Text(widget.category.toUpperCase()),
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