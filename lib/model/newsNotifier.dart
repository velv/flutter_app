import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_app/model/news.dart';

import 'service.dart';

// следим за состоянием списков новостей.
class NewsNotifier with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading;
  List<News> _newsList = [];
  List<dynamic> filterList = [];
  int countNews;
  int selectedIndex;
  addNewsToList(News news) {
    _newsList.add(news);
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  setIsLoading(bool load) {
    _isLoading = load;
  }

  setNewsBody(List<dynamic> body, newsIndex) {
    _newsList[newsIndex].desc = body;
    _isLoading = false;
    notifyListeners();
  }

  void onItemTap(index) {
    selectedIndex = index;
    notifyListeners();
  }

  removeNews(int index) {
    filterList.add(_newsList[index].newsUrl);
    box.write('filter', filterList);
    print(box.read('filter'));
    _newsList.removeAt(index);
    notifyListeners();
  }

  setNewsList(List<News> newsList) {
    _newsList = [];
    _newsList = newsList;
    notifyListeners();
  }

  List<News> getNewsList() {
    return _newsList;
  }

  // Парсим первые 12 новостей при запуске приложения
  initNews() {
    if (box.read('filter') != null) filterList = box.read('filter');
    print(filterList);
    selectedIndex = 0;
    countNews = 1;
    compute(NewsService.getMoeNews, countNews).then((result) {
      print(result.length);
      if (filterList != null) {
        print(filterList);
        List<News> itOg = filterMyList(result, filterList);
        setNewsList(itOg);
      } else {
        setNewsList(result);
      }
      //  print(box.read('filter'));
    });
    //Future.delayed(Duration(seconds: 5)).then((_) {
    //здесь
    //  });
  }

  moreNews() {
    List<News> globalNews = [];
    countNews++;
    compute(NewsService.getMoeNews, countNews).then((result) {
      print(result.length);
      if (filterList != null) {
        print(filterList);
        List<News> itOg = filterMyList(result, filterList);
        globalNews = [...getNewsList(), ...itOg];
        setNewsList(globalNews);
      } else {
        globalNews = [...getNewsList(), ...result];
        setNewsList(globalNews);
      }
    });
  }

  List<News> filterMyList(List<News> mynews, List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      mynews.removeWhere((element) => element.newsUrl == list[i]);
    }
    return mynews;
  }
}
