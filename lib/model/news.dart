class News {
  String title;
  String newsUrl;
  List<dynamic> desc;
  String imgURL;

  News();

  News.fromMap(
      [List<Map<String, dynamic>> data,
      int index,
      List<dynamic> list,
      String url,
      String picture]) {
    this.title = data[index]['title'];
    this.desc = list;
    this.newsUrl = url;
    this.imgURL = picture;
  }
}
