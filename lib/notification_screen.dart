import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          centerTitle: true,
          title: Text('Notifications',
            style: TextStyle(color: Colors.white, fontSize: 30),),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20),
              child:
              Column(
                children: [
                  _expandableNotifWidget(
                    '$_email', 'Title Placeholder', 'Subtitle Placeholder'
                  ),
                  _expandableNotifWidget(
                    '$_email', 'Title Placeholder', 'Subtitle Placeholder'
                  ),
                  _expandableNotifWidget(
                    '$_email', 'Title Placeholder', 'Subtitle Placeholder'
                  ),
                  _expandableNotifWidget(
                    '$_email', 'Title Placeholder', 'Subtitle Placeholder'
                  ),
                  _expandableNotifWidget(
                    '$_email', 'Title Placeholder', 'Subtitle Placeholder'
                  ),
                ],
              )
          ),
        )
    );
  }

  Widget _expandableNotifWidget(String email, String title, String message) {
    return Card(
      child: ExpansionTile(
        title: Text(
          title,
        ),
        children: [
          ListTile(
            subtitle: Text(
              "$message",
              style: TextStyle(color: AppColors.darkBackground),
            ),
          ),
        ],
      ),
    );
  }
}
