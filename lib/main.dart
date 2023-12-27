import 'package:app_flutter_esp32_brazo_robotico2/app.dart';
import 'package:app_flutter_esp32_brazo_robotico2/data.dart';
import 'package:app_flutter_esp32_brazo_robotico2/processList.dart';
import 'package:app_flutter_esp32_brazo_robotico2/test.dart';
import 'package:flutter/material.dart';

void main() {
  initData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quitar el banner de debug
      title: 'Mi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BottomNavDemo(),
      // home: Asdasdasdas(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class BottomNavDemo extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BottomNavDemoState createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<BottomNavDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const SliderArms(), const ProcessList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brazo Robotico'),
        // beautiful desing
        backgroundColor: Colors.amber,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swipe_down),
            label: 'Mov. Manual',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
