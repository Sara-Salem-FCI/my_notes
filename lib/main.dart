import 'package:flutter/material.dart';
import 'package:my_notes/shared_prefrences.dart';
import 'package:my_notes/views/home_screen.dart';
import 'package:my_notes/views/take_name_screen.dart';

import 'constants/colors.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        //scrollbarTheme: ,
        appBarTheme: const AppBarTheme(
          backgroundColor:kBackgroundColor,
          //scrolledUnderElevation: 0.0,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: CacheHelper.getString(key: 'firstName') == null? const TakeNameScreen() : const HomeScreen(),);
  }
}


