import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/firestore_variables.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.email});

  final String email;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          centerTitle: true,
          title: Text(
            'Reservations',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
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
        body: TabBarView(
          children: <Widget>[BookScreen(email: widget.email), ViewScreen(email: widget.email)],
        ),
      ),
    );
  }
}

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.email});

  final String email;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _guestCount = 1;

  String pickupAddress = '';
  String pickupCity = '';
  String pickupPostalCode = '';
  String pickupProvince = '';

  String dropoffAddress = '';
  String dropoffCity = '';
  String dropoffPostalCode = '';
  String dropoffProvince = '';

  // Dropdown
  String? _selectedVehicle;
  final List<String> carOptions = ["Audi", "Jeep", "Range Rover"];

  // Pickup controllers
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _pickupCityController = TextEditingController();
  final TextEditingController _pickupPostalCodeController =
      TextEditingController();
  final TextEditingController _pickupProvinceController =
      TextEditingController();

  // Dropoff controllers
  final TextEditingController _dropoffAddressController =
      TextEditingController();
  final TextEditingController _dropoffCityController = TextEditingController();
  final TextEditingController _dropoffPostalCodeController =
      TextEditingController();
  final TextEditingController _dropoffProvinceController =
      TextEditingController();

  //We should add a clear function to clear all the controllers
  clear() {
    _pickupAddressController.clear();
    _pickupCityController.clear();
    _pickupPostalCodeController.clear();
    _pickupProvinceController.clear();

    _dropoffAddressController.clear();
    _dropoffCityController.clear();
    _dropoffPostalCodeController.clear();
    _dropoffProvinceController.clear();

    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();

    _selectedVehicle = null;
    _guestCount = 1;

    setState(() {});
  }

  Future<Object> addReservation() async {
    pickupAddress = _pickupAddressController.text.trim();
    pickupCity = _pickupCityController.text.trim();
    pickupPostalCode = _pickupPostalCodeController.text.trim();
    pickupProvince = _pickupProvinceController.text.trim();

    // Car = _selectedVehicle!;
    // guestCount = _guestCount;
    if (!FirestoreVariables.isValidAddress(pickupAddress)) {
      return "Please enter a valid pickup address";
    }
    if (!FirestoreVariables.isValidCity(pickupCity)) {
      return "Please enter a valid pickup city";
    }
    if (!FirestoreVariables.isValidProvince(pickupProvince)) {
      return "Please enter a valid pickup province";
    }
    print(_pickupPostalCodeController.text.codeUnits);
    print(pickupPostalCode.codeUnits);
    if (!FirestoreVariables.isValidPostalCode(pickupPostalCode)) {
      return "Please enter a valid pickup postal code";
    }

    dropoffAddress = _dropoffAddressController.text.trim();
    dropoffCity = _dropoffCityController.text.trim();
    dropoffPostalCode = _dropoffPostalCodeController.text.trim();
    dropoffProvince = _dropoffProvinceController.text.trim();
    if (!FirestoreVariables.isValidAddress(dropoffAddress)) {
      return "Please enter a valid dropoff address";
    }
    if (!FirestoreVariables.isValidCity(dropoffCity)) {
      return "Please enter a valid dropoff city";
    }
    if (!FirestoreVariables.isValidPostalCode(dropoffPostalCode)) {
      return "Please enter a valid dropoff postal code";
    }
    if (!FirestoreVariables.isValidProvince(dropoffProvince)) {
      return "Please enter a valid dropoff province";
    }

    if (!(await FirestoreVariables.isValidDate(_selectedDate))) {
      return "Please enter a valid date";
    }

    if (!(await FirestoreVariables.isValidTime(_selectedDate, _selectedTime))) {
      return "Please enter a valid time";
    }

    print(_selectedTime);
    await FirestoreVariables.reservationCollection.add({
      'car': _selectedVehicle,
      'date': _selectedDate.toString(),
      'dropoffAddress': dropoffAddress,
      'dropoffCity': dropoffCity,
      'dropoffPostalCode': dropoffPostalCode,
      'dropoffProvince': dropoffProvince,
      'email': widget.email,
      'guests': _guestCount,
      'pickupAddress': pickupAddress,
      'pickupCity': pickupCity,
      'pickupPostalCode': pickupPostalCode,
      'pickupProvince': pickupProvince,
      'time': "${_selectedTime.hour}:${_selectedTime.minute}"
    });

    clear();

    // return "Reservation added successfully";
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reservation added successfully!")
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup location
                _buildSectionLabel("Pickup Location"),
                _buildInputBox(
                  child: Column(
                    children: [
                      _input("Address", _pickupAddressController),
                      _input("City", _pickupCityController),
                      _input("Postal Code", _pickupPostalCodeController),
                      _input("Province", _pickupProvinceController),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dropoff location
                _buildSectionLabel("Dropoff Location"),
                _buildInputBox(
                  child: Column(
                    children: [
                      _input("Address", _dropoffAddressController),
                      _input("City", _dropoffCityController),
                      _input("Postal Code", _dropoffPostalCodeController),
                      _input("Province", _dropoffProvinceController),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                _buildSectionLabel("Select a date"),
                GestureDetector(
                  onTap: _pickDate,
                  child: _buildInputBox(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month,
                            color: AppColors.accentGoldHover),
                        const SizedBox(width: 12),
                        Text(
                          "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}",
                          style:
                              const TextStyle(color: AppColors.darkBackground),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildSectionLabel("Select a time"),
                GestureDetector(
                  onTap: _pickTime,
                  child: _buildInputBox(
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            color: AppColors.accentGoldHover),
                        const SizedBox(width: 12),
                        Text(
                          _selectedTime.format(context),
                          style:
                              const TextStyle(color: AppColors.darkBackground),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Car dropdown
                _buildSectionLabel("Vehicle"),
                _buildInputBox(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      iconEnabledColor: AppColors.accentGoldHover,
                      style: const TextStyle(color: AppColors.darkBackground),
                      hint: const Text("Select a car"),
                      value: _selectedVehicle,
                      items: carOptions
                          .map((car) => DropdownMenuItem(
                                value: car,
                                child: Text(car),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedVehicle = value);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Guest counter
                _buildSectionLabel("Guests"),
                _buildInputBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _counterButton(
                        icon: Icons.remove,
                        onPressed: () {
                          setState(() {
                            if (_guestCount > 1) _guestCount--;
                          });
                        },
                      ),
                      Text(
                        "$_guestCount Guest${_guestCount > 1 ? 's' : ''}",
                        style: const TextStyle(
                            color: AppColors.darkBackground, fontSize: 16),
                      ),
                      _counterButton(
                        icon: Icons.add,
                        onPressed: () {
                          setState(() => _guestCount++);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Cancel and reserve buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.accentGoldHover),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          clear();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColors.accentGoldHover,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGoldHover,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                          addReservation();
                        },
                        child: const Text("Reserve",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  // Helper widgets
  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: AppColors.darkBackground),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.darkBackground),
        ),
      ),
    );
  }

  Widget _counterButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      child: IconButton(
        icon: Icon(icon, color: AppColors.accentGoldHover),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.accentGoldHover,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInputBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: _selectedDate,
    );

    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) setState(() => _selectedTime = picked);
  }
}

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key, required this.email});

  final String email;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  List<DocumentSnapshot> docSnapshots = [];

  /// Fetches all reservations belonging to the current user
  Future<void> fetchReservations(String email) async {
    final QuerySnapshot querySnapshot = await FirestoreVariables
        .reservationCollection
        .where('email', isEqualTo: email)
        .get();

    querySnapshot.docs.forEach((doc) {
      //Testing
      print("${doc['date']}, "
          "${doc['email']}, "
          "${doc['dropoffAddress']}, "
          "${doc['dropoffCity']}, "
          "${doc['dropoffPostalCode']}, "
          "${doc['dropoffProvince']}, "
          "${doc['pickupAddress']}, "
          "${doc['pickupCity']}, "
          "${doc['pickupPostalCode']}, "
          "${doc['pickupProvince']}, "
          "${doc['guests']}, "
          "${doc['time']}, "
          "${doc['date']}");
      setState(() {
        docSnapshots.add(doc);
      });
    });
  }

  @override
  void initState() {
    fetchReservations(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*SingleChildScrollView(
        child:*/
          Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(child: ListView.builder(
            itemCount: docSnapshots.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic>? data =
                  docSnapshots[index].data() as Map<String, dynamic>?;
              if (data != null) {
                print('/////////////////////////////////////////////////////////');
                print(data);
                print(docSnapshots.length);
                print('/////////////////////////////////////////////////////////');
                return ListTile(
                  title: Text('${data['date']}, ${data['time']}'),
                  subtitle: Text(data['car']),
                  trailing: Text('${data['guests']} guests'),
                );
              }
            },
          ))
        ]),
      ),
      /*),*/
    );
  }
}

Widget _reservationTileWidget(DateTime date, TimeOfDay time, String car, int guests) {
  return ListTile(

  );
}
