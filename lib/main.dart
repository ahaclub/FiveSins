import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home_page.dart';
import 'tools/navigator_tool.dart';
import 'tools/system_tool.dart';

void main() async {
  runApp(MyApp());
  SystemTool.keepPortrait();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FiveSins',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        splashColor: Colors.transparent,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.black45,
        primarySwatch: Colors.yellow,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      navigatorObservers: [NavigatorTool()],
      home: HomePage(),
    );
  }
}
