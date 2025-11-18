import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          ListTile(
              title: Text('Title Placeholder'),
              subtitle: Text('Subtitle Placeholder'),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more)
                  ),
                ],
              )
          ),
          ListTile(
              title: Text('Title Placeholder'),
              subtitle: Text('Subtitle Placeholder'),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.expand_more)
                  ),
                ],
              )
          ),
        ],
      )
    );
  }
}
