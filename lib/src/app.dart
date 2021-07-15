
import 'package:flutter/material.dart';
import 'package:search_snackbar_bottomsheet_flutter/src/screen/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}