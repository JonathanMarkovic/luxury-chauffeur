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
              _expandableCarWidget('assets/jeep.jpg', 'Jeep', 'Comfortably Seat 5 passengers and ride in style.', 200),
              _expandableCarWidget('assets/audi.jpg', 'Audi', 'Comfortably Seat 3 passengers and ride in style.', 150),
              _expandableCarWidget('assets/range_rover.jpg', 'Range Rover', 'Comfortably Seat 5 passengers and ride in style.', 250),
            ],
          ),
        ),
      )
    );
  }
}

Widget _expandableCarWidget(String imagePath, String name, String description, double price) {
  return Card(
    child: ExpansionTile(
      title: Image(image: AssetImage(imagePath)),
      children: [
        ListTile(
          title: Text(
            name,
          ),
          trailing: Text('\$ $price / hour'),
          subtitle: Text(
            description, style: TextStyle(color: AppColors.darkBackground),
          ),
        ),
      ],
    ),
  );
}
