import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/categoryModels.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/views/article_view.dart';

import 'category_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModels> categories = <CategoryModels>[];
  List<ArticleModel> articleModel = <ArticleModel>[];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    articleModel = newsClass.articles;
    await newsClass.getHeadlineNews();
    setState(() {
      loading = false;
    });
    print('article model length: ${articleModel.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Insight',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Blend',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // categories
                    Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl ?? "",
                              categoryName:
                                  categories[index].categoryName ?? "",
                              channelName: categories[index].channelName,
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Trending',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(' News',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Top News
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: MediaQuery.of(context).size.height * 0.72,
                      child: ListView.builder(
                          itemCount: articleModel.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              urlToImage: articleModel[index].urlToImage ?? '',
                              title: articleModel[index].title ?? '',
                              desc: articleModel[index].description ?? '',
                              blogUrl: articleModel[index].url ?? '',
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

class CategoryTile extends StatelessWidget {
  final String? imageUrl, categoryName, channelName;
  const CategoryTile(
      {super.key,
      required this.imageUrl,
      required this.categoryName,
      this.channelName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CategoryNews(
                      newsChannel: channelName!.toLowerCase(),
                    ))));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? '',
                width: 150,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 75,
              decoration: BoxDecoration(color: Colors.black26),
              child: Text(
                categoryName ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String urlToImage, title, desc, blogUrl;

  const BlogTile(
      {super.key,
      required this.urlToImage,
      required this.title,
      required this.desc,
      required this.blogUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(imageUrl: urlToImage)),
        SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 23, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          desc,
          style: const TextStyle(color: Colors.black54),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleView(blogUrl: blogUrl)));
                },
                child: const Text('Read More')))
      ]),
    );
  }
}
