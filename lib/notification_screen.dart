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
        backgroundColor: AppColors.darkBackground,
        centerTitle: true,
        title: Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child:
            Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Title Placeholder', style: TextStyle(color: Colors.black),),
                    subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.darkBackground),),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.expand_more, color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Title Placeholder', style: TextStyle(color: Colors.black),),
                    subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.darkBackground),),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.expand_more, color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Title Placeholder', style: TextStyle(color: Colors.black),),
                    subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.darkBackground),),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.expand_more, color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Title Placeholder', style: TextStyle(color: Colors.black),),
                    subtitle: Text('Subtitle Placeholder', style: TextStyle(color: AppColors.darkBackground),),
                    trailing: Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.expand_more, color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      )
    );
  }
}
