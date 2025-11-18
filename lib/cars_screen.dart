import 'package:flutter/material.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage('jeep.jpg')),
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
                Image(image: AssetImage('audi.jpg')),
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
                Image(image: AssetImage('range_rover.jpg')),
                ListTile(
                  title: Text('Range Rover'),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
                )              ],
            ),
          )
        ],
      ),
    );
  }
}
