import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String newsChannel;
  const CategoryNews({super.key, required this.newsChannel});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articleModel = <ArticleModel>[];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    AllCategoryNews newsClass = AllCategoryNews();
    articleModel = newsClass.articles;
    await newsClass.getAllNews(widget.newsChannel);
    setState(() {
      loading = false;
    });
    print('article model length: ${articleModel.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Insight',
              style: TextStyle(color: Colors.black),
            ),
            const Text(
              'Blend',
              style: TextStyle(color: Colors.blue),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.save))
          ],
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: MediaQuery.of(context).size.height * 0.90,
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
              child: Image.network(
                imageUrl ?? '',
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
