import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/meals.dart';
import 'pages/pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 7, 187, 181),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedElement = 0;

  static final List<Widget> _pages = <Widget>[
    Home(),
    const MealsPage(),
    const PreferencesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedElement = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Test'),
        elevation: 12,
        scrolledUnderElevation: 4,
        centerTitle: true,
      ),
      body: Center(child: _pages.elementAt(_selectedElement)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined),
            label: 'Add',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Preferences',
          ),
        ],
        currentIndex: _selectedElement,
        unselectedItemColor: Color.fromARGB(100, 10, 10, 10),
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
