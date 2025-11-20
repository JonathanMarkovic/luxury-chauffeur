import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/account_screen.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/cars_screen.dart';
import 'package:luxury_chauffeur/notification_screen.dart';
import 'package:luxury_chauffeur/reservation_screen.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BottomNavigationBarExample(), debugShowCheckedModeBanner: false,);
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    NotificationScreen(),
    CarsScreen(),
    ReservationScreen(),
    AccountScreen(email: '',)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.darkBackground
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car_filled), label: 'Cars'),
            BottomNavigationBarItem(icon: Icon(Icons.event_available_sharp), label: 'Reservations'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.accentGoldHover,
          unselectedItemColor: AppColors.accentGrayHover,
          backgroundColor: AppColors.darkBackground,
          onTap: _onItemTapped,
        ),
      )
    );
  }
}