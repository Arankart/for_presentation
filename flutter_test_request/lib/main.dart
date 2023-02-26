// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_request/presentation/ui/pages/pizza_check_order_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'domain/style.dart';
import 'firebase_options.dart';
import 'presentation/ui/pages/bag_page.dart';
import 'presentation/ui/pages/menu_page.dart';
import 'presentation/ui/pages/pizza_page.dart';
import 'presentation/ui/pages/profile_page.dart';
import 'presentation/ui/pages/story_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const WrappedWidget(),
      routes: {
        '/menu_page': (context) => MyHomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/bag_page': (context) => BagPage(),
        '/pizza_page': (context) => PizzaPage(),
        '/story_page': (context) => StoryPage(),
        '/pizza_check_order_page': (context) => PizzaChekOrderPage(),
      },
    );
  }
}

class WrappedWidget extends StatefulWidget {
  const WrappedWidget({super.key});

  @override
  State<WrappedWidget> createState() => _WrappedWidgetState();
}

class _WrappedWidgetState extends State<WrappedWidget> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    ProfilePage(),
    BagPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //       child: Text(
      //     "Страус пицца ❤️",
      //     style: labelAppStyle,
      //   )),
      // ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.maps_home_work_outlined),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_outlined),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Корзина',
          ),
        ],
        selectedItemColor: primeryColor,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
