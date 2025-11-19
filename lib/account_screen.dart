import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        centerTitle: true,
        title: Text('Account', style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Personal Information', style: TextStyle(fontSize: 22),),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text('Edit', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      ListTile(
                        title: Text('First Name'),
                        trailing: Text('Get from database'),
                      ),
                      ListTile(
                        title: Text('Last Name'),
                        trailing: Text('Get from database'),
                      ),
                      ListTile(
                        title: Text('Email'),
                        trailing: Text('Get from database'),
                      ),
                      ListTile(
                        title: Text('Phone Number'),
                        trailing: Text('Get from database'),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Logout', style: TextStyle(fontSize: 18, color: AppColors.darkBackground),),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    fixedSize: WidgetStateProperty.all(Size(120, 30)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
