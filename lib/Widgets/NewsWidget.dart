// Виджет новостей
import 'package:flutter/material.dart';
import 'package:flutter_app/model/newsNotifier.dart';
import 'package:flutter_app/model/service.dart';
import 'package:provider/provider.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsNotifier newsNotifier = context.watch<NewsNotifier>();
    print('build mylist');
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: newsNotifier.getNewsList().length + 1,
      itemBuilder: (BuildContext context, int newsCount) {
        if (newsCount == newsNotifier.getNewsList().length)
          return RaisedButton(
            onPressed: NewsService(newsNotifier).moreNews,
            child:
                const Text('Больше новостей', style: TextStyle(fontSize: 15)),
          );
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              newsNotifier.removeNews(newsCount);
            } else if (direction == DismissDirection.endToStart) {
              // Scaffold.of(context).showSnackBar(
              //      SnackBar(content: Text("Добавляем в избранное")));
            }
          },
          background: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.0),
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10.0),
            color: Colors.green,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/newsBody',
                    arguments: {'newsCount': newsCount},
                  );
                },
                //  ScreenManager(context, '/newsBody', newsCount).newsBodyScreen,
                child: Text(newsNotifier.getNewsList()[newsCount].title),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Widget> allMyItems = [
  MyList(),
  Center(child: Text('чАт')),
  Center(child: Text('настройки')),
];
