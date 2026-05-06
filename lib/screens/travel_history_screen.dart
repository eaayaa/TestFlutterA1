import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Travel History'),
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildHistoryCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search trips...',
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.orange),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, int index) {
    final List<Map<String, String>> mockHistory = [
      {'from': 'New York', 'to': 'Washington', 'date': '15 Aug 2024', 'price': '\$120', 'train': 'Acela Express'},
      {'from': 'Boston', 'to': 'New York', 'date': '02 Jul 2024', 'price': '\$85', 'train': 'Northeast Regional'},
      {'from': 'Philadelphia', 'to': 'D.C.', 'date': '20 May 2024', 'price': '\$45', 'train': 'Palmetto'},
    ];

    final trip = mockHistory[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _buildStationInfo(trip['from']!, true),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.orange),
                        Expanded(child: Divider(color: Colors.orange)),
                        Icon(Icons.train_rounded, size: 16, color: Colors.orange),
                        Expanded(child: Divider(color: Colors.orange)),
                        Icon(Icons.circle, size: 8, color: Colors.orange),
                      ],
                    ),
                  ),
                ),
                _buildStationInfo(trip['to']!, false),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Date', trip['date']!),
                _buildInfoColumn('Price', trip['price']!),
                _buildInfoColumn('Train', trip['train']!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationInfo(String city, bool isStart) {
    return Column(
      crossAxisAlignment: isStart ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(city, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(isStart ? 'Departure' : 'Arrival', style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}
