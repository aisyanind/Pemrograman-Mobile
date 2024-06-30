import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/item_viewmodel.dart';
import 'viewmodels/user_viewmodel.dart';
import 'views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Mengatur HomePage sebagai halaman utama
    );
  }
}
