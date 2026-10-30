import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPlanScreen extends StatefulWidget {
const AddPlanScreen({super.key});
  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();
  final _descController = TextEditingController();
  final _hostController = TextEditingController();
  final _slotsController = TextEditingController();
  
  String selectedType = 'Carpool';
  bool isLoading = false;

  final List<String> tripTypes = ['Carpool', 'Bike Ride', 'Trek'];

  void _postTrip() async {
    if (_titleController.text.isEmpty || _budgetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the required fields!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('trips').add({
        'title': _titleController.text.trim(),
        'budget': '₹${_budgetController.text.trim()}',
        'description': _descController.text.trim(),
        'host': _hostController.text.trim().isNotEmpty ? _hostController.text.trim() : 'Mushahid (Kallu)',
        'type': selectedType,
        'date': '15 Sept 2026, 7:30 am',
        'slots': _slotsController.text.trim().isNotEmpty ? _slotsController.text.trim() : '3 Vacant Slots Left',
        'createdAt': FieldValue.serverTimestamp(),
      });
      Future<void> someAsyncFunction() async {
  // Apni async logic ya API/Firebase call yahan likho
}
      await someAsyncFunction();
if (!mounted) return; 

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trip posted successfully!')),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00695C),
        title: const Text(
          'Post New Trip',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Your Trip Pooling Plan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00695C)),
              ),
              const SizedBox(height: 16),

              // Trip Type Dropdown
              const Text('Select Trip Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedType,
                    isExpanded: true,
                    items: tripTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type == 'Carpool' ? '🚗 Carpool' : type == 'Bike Ride' ? '🏍️ Bike Ride' : '🏕️ Trek'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Trip Title (e.g. Lonavala Weekend Chill)',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00695C), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Budget Field
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Budget per Head (e.g. 850)',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00695C), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description Field
              TextField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description / Message (e.g. Leaving early morning...)',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00695C), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Slots Field
              TextField(
                controller: _slotsController,
                decoration: InputDecoration(
                  labelText: 'Vacant Slots (e.g. 3 Vacant Slots Left)',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00695C), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Host Name Field
              TextField(
                controller: _hostController,
                decoration: InputDecoration(
                  labelText: 'Host Name (e.g. Mushahid (Kallu))',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00695C), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Publish Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00695C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : _postTrip,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Publish Trip',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}