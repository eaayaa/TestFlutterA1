import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/train_model.dart';

class BookingScreen extends StatefulWidget {
  final Train train;
  final String selectedClass;

  const BookingScreen({
    super.key,
    required this.train,
    required this.selectedClass,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<String> selectedSeats = [];
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void toggleSeat(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passenger Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 32),
            const Text(
              'Select Your Seat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSeatLegend(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  for (int row = 1; row <= 8; row++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSeat(row, 'A'),
                          _buildSeat(row, 'B'),
                          const SizedBox(width: 30),
                          _buildSeat(row, 'C'),
                          _buildSeat(row, 'D'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: selectedSeats.isEmpty
              ? null
              : () {
                  _showSuccessDialog();
                },
          child: Text(
            selectedSeats.isEmpty 
              ? 'Select a Seat' 
              : 'Pay \$${(widget.train.basePrice * selectedSeats.length).toStringAsFixed(0)}',
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _buildSeat(int row, String col) {
    final seatId = '$row$col';
    final isSelected = selectedSeats.contains(seatId);
    final isReserved = (row == 2 && col == 'B') || (row == 5 && col == 'D'); // Mock reserved seats

    return GestureDetector(
      onTap: isReserved ? null : () => toggleSeat(seatId),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isReserved 
              ? Colors.grey[300] 
              : isSelected 
                  ? Theme.of(context).colorScheme.primary 
                  : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeatLegend() {
    return Row(
      children: [
        _legendItem('Available', Colors.white, Colors.grey.withOpacity(0.3)),
        const SizedBox(width: 16),
        _legendItem('Selected', Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        _legendItem('Reserved', Colors.grey[300]!, Colors.grey[300]!),
      ],
    );
  }

  Widget _legendItem(String label, Color color, Color borderColor) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_afmre9iz.json',
                repeat: false,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Booking Successful!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Your ticket for ${widget.train.name} has been confirmed.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
