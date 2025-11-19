import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/start_screen.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          centerTitle: true,
          title: Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 30),),
          bottom: const TabBar(
            labelColor: AppColors.accentGoldHover,
            indicatorColor: AppColors.accentGoldHover,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(child: Text('Book')),
              Tab(child: Text('View')),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            BookScreen(),
            ViewScreen()
          ],
        ),
      ),
    );
  }
}

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text('Hello'),
      )
    );
  }
}

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text('Bye'),
      ),
    );
  }
}

