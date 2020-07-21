import 'package:flutter/material.dart';

import 'package:flutterapp/model/news.dart';

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
}
