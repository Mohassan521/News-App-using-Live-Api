import 'dart:convert';

import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> articles = [];

  //fox-sports,bbc-sport

  Future<void> getHeadlineNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=usa-today&apiKey=c34bdef29bb64227bd28523ea655c6cb";
    var response = await http.get(Uri.parse(url));
    var decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      decodedData["articles"].forEach((element) {
        ArticleModel articleModel = ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          //publishedAt: element["publishedAt'] as DateTime
        );
        articles.add(articleModel);
      });
    }
  }
}

class AllCategoryNews {
  List<ArticleModel> articles = [];

  //fox-sports,bbc-sport

  Future<void> getAllNews(String channel) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=c34bdef29bb64227bd28523ea655c6cb";
    var response = await http.get(Uri.parse(url));
    var decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      decodedData["articles"].forEach((element) {
        ArticleModel articleModel = ArticleModel(
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          //publishedAt: element["publishedAt'] as DateTime
        );
        articles.add(articleModel);
      });
    }
  }
}
