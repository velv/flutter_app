import 'package:flutter/material.dart';

import 'package:flutter_app/model/news.dart';
import 'package:worker_manager/worker_manager.dart';

import 'service.dart';

// следим за состоянием списков новостей.
class NewsNotifier with ChangeNotifier {
  List<News> _newsList = [];
  int countNews;
  int selectedIndex;
  addNewsToList(News news) {
    _newsList.add(news);
    notifyListeners();
  }

  void onItemTap(index) {
    selectedIndex = index;
    notifyListeners();
  }

  removeNews(int index) {
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
    selectedIndex = 0;
    countNews = 1;
    Executor().execute(arg1: countNews, fun1: NewsService.getMoeNews).then((result) {
      print(result.length);
      setNewsList(result);
    });
    //Future.delayed(Duration(seconds: 5)).then((_) {
    //здесь
    //  });
  }

  moreNews() {
    List<News> globalNews = [];
    countNews++;
    Executor().execute(arg1: countNews, fun1: NewsService.getMoeNews).then((result) {
      print(result.length);
      globalNews = [...getNewsList(), ...result];
      setNewsList(globalNews);
    });
  }
}
