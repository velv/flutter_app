import 'package:flutter/cupertino.dart';
import 'package:flutter_app/model/news.dart';
import 'package:flutter_app/model/newsNotifier.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:provider/provider.dart';

// Основная логика, парсим сайты.
class NewsService {
  NewsService();
  //  Парсим новости с сайта  газеты МОЕ
  static Future<List<News>> getMoeNews(int count) async {
    print('parsim infu s saita');
    String fullPictureUrl;
    List<News> moeNewsList = [];
    // Временные списки
    List<Map<String, dynamic>> _linksAndTitles, _pictures = [];
    // Временный список, который хранит тело новости
    //   List<dynamic> _bodyList = [];
    final String moeUrl = 'https://moe-online.ru';
    final webScraper = WebScraper(moeUrl);
    //========================
    for (int ind = 1; ind < count + 1; ind++) {
      if (await webScraper.loadWebPage('/news/city?page=' + count.toString())) {
        _linksAndTitles = webScraper.getElement('a.plitka_text', ['href']);
        _pictures = webScraper.getElement('div.plitka_img > a.plitka_img', ['style']);
        for (int i = 0; i < _linksAndTitles.length; i++) {
          // Делаем нормальную ссылку на тело новости
          String fullUrl = moeUrl + _linksAndTitles[i]['attributes']['href'];
          //получаем нормальную ссылку на картинку для новости
          fullPictureUrl = _pictures[i]['attributes']['style'].substring(22, _pictures[i]['attributes']['style'].length - 2);
          //==========================================
          //   final response = await http.Client().get(Uri.parse(fullUrl));
          //  var document = parse(response.body);
          //      if (response.statusCode == 200) {
          //         _bodyList = document.getElementsByClassName("app_in_text").elementAt(0).querySelectorAll("p").toList();
          //     }
          // Формируем список новостей с сайта (каждая новость включает заголовок, ссылки на картинку и тело новости)
          moeNewsList.add(News.fromMap(data: _linksAndTitles, index: i, url: fullUrl, picture: fullPictureUrl));
        }
      }
    }
    print('zakonchili s parsingom');
    return moeNewsList;
  }

  getNewsBody(BuildContext ctx, int newsIndex) async {
    ctx.read<NewsNotifier>().setIsLoading(true);
    List<dynamic> _bodyList = [];
    final response = await http.Client().get(Uri.parse(ctx.read<NewsNotifier>().getNewsList()[newsIndex].newsUrl));
    var document = parse(response.body);
    if (response.statusCode == 200) {
      _bodyList = document.getElementsByClassName("app_in_text").elementAt(0).querySelectorAll("p").toList();
    }
    ctx.read<NewsNotifier>().setNewsBody(_bodyList, newsIndex);
  }
  //////////end
}
