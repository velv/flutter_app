import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Widgets/Bar.dart';
import 'Widgets/NewsWidget.dart';
import 'model/newsNotifier.dart';
import 'Screen/newsbody.dart';
import 'package:get_storage/get_storage.dart';

// тест
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NewsNotifier(),
          ),
        ],
        child: StartupCaller(),
      ),
    );
  });
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class StartupCaller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        context.read<NewsNotifier>().initNews();
      },
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('myApp');
    return MaterialApp(
      title: 'Flutter Demo',
      //   initialRoute: '/',
      routes: {
        '/newsBody': (context) => NewsBody(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build main ');
    return Scaffold(
      body: allMyItems[context.watch<NewsNotifier>().selectedIndex],
      bottomNavigationBar: MyBarr(),
    );
// end of build
  }
}
