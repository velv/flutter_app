import 'package:flutter/material.dart';
import 'package:flutterapp/Widgets/NewsPicture.dart';
import 'package:flutterapp/model/newsNotifier.dart';
import 'package:provider/provider.dart';

// Экран где отображается тело новости.
class NewsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // передаем аргументы (счетчик новостей) К каждой новости - свое тело.
    // newsCount - счетчик новостей, newsBodyCount - счетчик абзацов в теле новости.
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    NewsNotifier newsNotifier = context.watch<NewsNotifier>();
    print('build body');
    return Scaffold(
      //   appBar: AppBar(
      //      title: Text(newsNotifier.getNewsList()[routeArgs['newsCount']].title),
      //    ),
      body: ListView(
        children: [
          // Рисуем картинку
          newsPicture(
              newsNotifier.getNewsList()[routeArgs['newsCount']].imgURL),
          SizedBox(height: 10),
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            // билдим каждый абзац тела новости
            itemCount:
                newsNotifier.getNewsList()[routeArgs['newsCount']].desc.length,
            itemBuilder: (BuildContext context, int newsBodyCount) {
              return Text(newsNotifier
                  .getNewsList()[routeArgs['newsCount']]
                  .desc[newsBodyCount]
                  .text);
            },
          ),
        ],
      ),
    );
  }
}
