import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          ListTile(
              title: Text('Title Placeholder', style: TextStyle(color: Colors.white),),
              subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.lightBackground),),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more, color: Colors.white,)
                  ),
                ],
              )
          ),
          ListTile(
              title: Text('Title Placeholder', style: TextStyle(color: Colors.white),),
              subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.lightBackground),),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more, color: Colors.white,)
                  ),
                ],
              )
          ),
          ListTile(
              title: Text('Title Placeholder', style: TextStyle(color: Colors.white),),
              subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.lightBackground),),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more, color: Colors.white,)
                  ),
                ],
              )
          ),
          ListTile(
              title: Text('Title Placeholder', style: TextStyle(color: Colors.white),),
              subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.lightBackground),),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more, color: Colors.white,)
                  ),
                ],
              )
          ),
        ],
      )
    );
  }
}
