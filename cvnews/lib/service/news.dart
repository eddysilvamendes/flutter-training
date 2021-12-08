import 'dart:convert';

import 'package:cvnews/moduls/articleModel.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async{



    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a62441f060d7459bb9fcafe6abe3e912";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((e){
        if(e["urlToImage"] != null && e["description"] != null && e["author"] != null && e["content"] != null){
          ArticleModel articleModel = ArticleModel(
              title: e["title"],
              description: e["description"],
              author: e["author"],
              content: e["content"],
              urlToImage: e["urlToImage"],
            articleUrl: e["url"],);
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews{
  List<ArticleModel> categorynews = [];
  Future<void> getCategoryNews(String category) async{



    String url = "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=a62441f060d7459bb9fcafe6abe3e912";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((e){
        if(e["urlToImage"] != null && e["description"] != null && e["author"] != null && e["content"] != null){
          ArticleModel articleModel = ArticleModel(
            title: e["title"],
            description: e["description"],
            author: e["author"],
            content: e["content"],
            urlToImage: e["urlToImage"],
            articleUrl: e["url"],);
          categorynews.add(articleModel);
        }
      });
    }
  }
}

class SearchNews{
  List<ArticleModel> searchnews = [];
  Future<void> getSearchedNews(String search) async{



    String url = "https://newsapi.org/v2/everything?q=$search&from=2021-08-01&sortBy=popularity&apiKey=a62441f060d7459bb9fcafe6abe3e912";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((e){
        if(e["urlToImage"] != null && e["description"] != null && e["author"] != null && e["content"] != null){
          ArticleModel articleModel = ArticleModel(
            title: e["title"],
            description: e["description"],
            author: e["author"],
            content: e["content"],
            urlToImage: e["urlToImage"],
            articleUrl: e["url"],);
          searchnews.add(articleModel);
        }
      });
    }
  }
}