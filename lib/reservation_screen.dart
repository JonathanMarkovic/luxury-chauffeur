import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/firestore_variables.dart';
import 'package:luxury_chauffeur/helper_functions.dart';

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
  const BookScreen({super.key, required this.email, this.editingDoc});

  final String email;
  final DocumentSnapshot? editingDoc;

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

  // Editing
  bool isEditing = false;
  String editingId = "";

  void clear() {
    _pickupAddressController.clear();
    _pickupCityController.clear();
  }

  Future<void> addReservation() async {
    final pickupAddress = _pickupAddressController.text.trim();
    final dropoffAddress = _dropoffAddressController.text.trim();

    if (pickupAddress.isEmpty || dropoffAddress.isEmpty || _selectedVehicle == null) {
      HelperFunctions.showSnackBar(context, "Please fill in all fields");
    }

    if (!FirestoreVariables.isValidAddress(pickupAddress)) {
      HelperFunctions.showSnackBar(context, "Please enter a valid pickup address");
      return;
    }
    if (!FirestoreVariables.isValidAddress(dropoffAddress)) {
      HelperFunctions.showSnackBar(context, "Please enter a valid drop-off address");
      return;
    }
    if (_selectedVehicle == null) {
      HelperFunctions.showSnackBar(context, "Please select a vehicle");
      return;
    }
    if (!(await FirestoreVariables.isValidDate(_selectedDate))) {
      HelperFunctions.showSnackBar(context, "Please enter a valid date");
      return;
    }
    if (!(await FirestoreVariables.isValidTime(_selectedDate, _selectedTime))) {
      HelperFunctions.showSnackBar(context, "Please enter a valid time");
      return;
    }

    try {
      await FirestoreVariables.reservationCollection.add({
        'car': _selectedVehicle,
        'date': _selectedDate.toIso8601String(),
        'dropoffAddress': dropoffAddress,
        'email': widget.email,
        'guests': _guestCount,
        'pickupAddress': pickupAddress,
        'time': "${_selectedTime.hour.toString().padLeft(2,'0')}:${_selectedTime.minute.toString().padLeft(2,'0')}"
      });

      HelperFunctions.showSnackBar(context, "Reservation added successfully");

      // clear fields
      _pickupAddressController.clear();
      _dropoffAddressController.clear();
      setState(() {
        _selectedVehicle = null;
        _guestCount = 1;
        _selectedDate = DateTime.now();
        _selectedTime = TimeOfDay.now();
      });

      // switch to View tab (only works if DefaultTabController is an ancestor)
      final tabController = DefaultTabController.of(context);
      if (tabController != null) tabController.animateTo(1);

    } catch (e, st) {
      print("Failed to add reservation: $e\n$st");
      HelperFunctions.showSnackBar(context, "Failed to add reservation");
    }
  }

  Future<void> _editReservation() async {
    try {
      await FirebaseFirestore.instance
          .collection("reservations")
          .doc(editingId)
          .update({
            'pickupAddress': _pickupAddressController.text.trim(),
            'dropoffAddress': _dropoffAddressController.text.trim(),
            'car': _selectedVehicle,
            'guests': _guestCount,
            'date': _selectedDate.toIso8601String(),
            'time': "${_selectedTime.hour.toString().padLeft(2,'0')}:${_selectedTime.minute.toString().padLeft(2,'0')}",
          });

      HelperFunctions.showSnackBar(context, "Reservation updated successfully");

      final tab = DefaultTabController.of(context);
      // go back to view tab
      if (tab != null) tab.animateTo(1);
    } catch (e) {
      HelperFunctions.showSnackBar(context, "Failed to update reservation");
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.editingDoc != null) {
      final data = widget.editingDoc!.data() as Map<String, dynamic>;

      isEditing = true;
      editingId = widget.editingDoc!.id;

      // fill in the fields
      _pickupAddressController.text = data['pickupAddress'] ?? "";
      _dropoffAddressController.text = data['dropoffAddress'] ?? "";
      _selectedVehicle = data['car'];
      _guestCount = data['guests'] ?? 1;
      
      // parse date
      _selectedDate = DateTime.parse(data['date']);
      
      // parse time hh:mm
      final timeParts = data['time'].split(':');
      _selectedTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.darkBackground,
        child: SingleChildScrollView(
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
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dropoff location
                _buildSectionLabel("Drop-off Location"),
                _buildInputBox(
                  child: Column(
                    children: [
                      _input("Address", _dropoffAddressController),
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
                        onPressed: () {},
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
                          if (isEditing) {
                            await _editReservation();
                          }
                          else {
                            await addReservation();
                          }
                        },
                        child: Text(isEditing ? "Save" : "Reserve",
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
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
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

  Future<void> fetchReservations(String email) async {
    try {
      docSnapshots.clear();
      final QuerySnapshot querySnapshot = await FirestoreVariables
          .reservationCollection
          .where('email', isEqualTo: email)
          .get();

      for (final doc in querySnapshot.docs) {
        // guard access to fields that may be missing
        final data = doc.data() as Map<String, dynamic>? ?? {};
        print("doc ${doc.id}: $data");

        setState(() {
          docSnapshots.add(doc);
        });
      }
    } catch (e, st) {
      print("fetchReservations error: $e\n$st");
      // Show a snackbar if needed — but make sure context is valid
      if (mounted) HelperFunctions.showSnackBar(context, "Failed to fetch reservations");
    }
  }

  Future<void> _deleteReservation(String id) async {
    try {
      await FirebaseFirestore.instance.collection("reservations").doc(id).delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Reservation cancelled successfully"))
        );
      }

      await fetchReservations(widget.email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete reservation"))
      );
    }

  }

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBackground,
          title: Text("Cancel Reservation", style: TextStyle(color: Colors.white)),
          content: Text("Are you sure you want to cancel this reservation?",
              style: TextStyle(color: AppColors.accentGray)),
          actions: [
            TextButton(
              child: Text("No", style: TextStyle(color: AppColors.accentGoldHover)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Yes", style: TextStyle(color: Colors.redAccent)),
              onPressed: () async {
                Navigator.pop(context);
                await _deleteReservation(docId);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    fetchReservations(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: docSnapshots.length,
              itemBuilder: (context, index) {
                final data = docSnapshots[index].data() as Map<String, dynamic>? ?? {};
                final trimmedDate = (data['date'] ?? '').toString().split('T')[0];
                final car = (data['car'] ?? 'No vehicle selected').toString();
                final time = (data['time'] ?? 'Unknown').toString();
                final guests = (data['guests'] ?? 0).toString();

                return ListTile(
                  title: Text('$trimmedDate, $time', style: TextStyle(color: Colors.white)),
                  subtitle: Text(car, style: TextStyle(color: AppColors.accentGray)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$guests guests', style: TextStyle(color: AppColors.accentGray)),
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.accentGoldHover),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReservationScreen(
                                email: widget.email,
                                // open Book tab with editing data
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: AppColors.accentGoldHover),
                        onPressed: () {
                          _confirmDelete(context, docSnapshots[index].id);
                        },
                      ),
                    ],
                  ),
                );
              }
            )
          )
        ]),
      ),
    );
  }
}
