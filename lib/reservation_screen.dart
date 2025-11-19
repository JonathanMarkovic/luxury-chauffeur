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
          title: Text('Reservations', style: TextStyle(color: Colors.white, fontSize: 30),),
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
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _pickupCityController = TextEditingController();
  final TextEditingController _pickupPostalCodeController = TextEditingController();
  final TextEditingController _pickupProvinceController = TextEditingController();

  final TextEditingController _dropoffAddressController = TextEditingController();
  final TextEditingController _dropoffCityController = TextEditingController();
  final TextEditingController _dropoffPostalCodeController = TextEditingController();
  final TextEditingController _dropoffProvinceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DatePickerDialog(firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day)),
                TimePickerDialog(initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)),
                SizedBox(height: 20,),
                Card(
                  color: AppColors.darkerGray,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24
                    ),
                    child: Column(
                      children: [
                        Text('Pickup Location'),
                        TextField(
                          controller: _pickupAddressController,
                          decoration: InputDecoration(labelText: 'Address'),
                        ),
                        TextField(
                          controller: _pickupCityController,
                          decoration: InputDecoration(labelText: 'City'),
                        ),
                        TextField(
                          controller: _pickupPostalCodeController,
                          decoration: InputDecoration(labelText: 'Postal Code'),
                        ),
                        TextField(
                          controller: _pickupProvinceController,
                          decoration: InputDecoration(labelText: 'Province'),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(height: 20,),
                Card(
                  color: AppColors.darkerGray,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24
                      ),
                      child: Column(
                        children: [
                          Text('Dropoff Location'),
                          TextField(
                            controller: _dropoffAddressController,
                            decoration: InputDecoration(labelText: 'Address'),
                          ),
                          TextField(
                            controller: _dropoffCityController,
                            decoration: InputDecoration(labelText: 'City'),
                          ),
                          TextField(
                            controller: _dropoffPostalCodeController,
                            decoration: InputDecoration(labelText: 'Postal Code'),
                          ),
                          TextField(
                            controller: _dropoffProvinceController,
                            decoration: InputDecoration(labelText: 'Province'),
                          ),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Login', style: TextStyle(fontSize: 18),),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                      foregroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      fixedSize: WidgetStateProperty.all(Size(120, 30))
                  ),
                ),
              ],
            ),
          )
      ),
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
      
    );
  }
}

