import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/dummy_data.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('My Tickets', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 2, // Dummy count
        itemBuilder: (context, index) {
          return _buildTicketCard(context);
        },
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStationInfo('NYC', 'New York', true),
                Column(
                  children: [
                    const Icon(Icons.train_rounded, color: Colors.orange, size: 20),
                    Container(
                      width: 80,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    const Text('3h 30m', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                _buildStationInfo('WAS', 'Washington', false),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetail('Date', '12 Oct 2024'),
                _buildDetail('Seat', '12A, 12B'),
                _buildDetail('Class', 'Business'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationInfo(String code, String city, bool isStart) {
    return Column(
      crossAxisAlignment: isStart ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(code, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(city, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
