import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text('Cars', style: TextStyle(color: Colors.white, fontSize: 30),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(image: AssetImage('assets/jeep.jpg')),
                    ListTile(
                      title: Text('Jeep'),
                      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
                    )              ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(image: AssetImage('assets/audi.jpg')),
                    ListTile(
                      title: Text('Audi'),
                      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(image: AssetImage('assets/range_rover.jpg')),
                    ListTile(
                      title: Text('Range Rover'),
                      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
                    )              ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
