import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/train_model.dart';
import '../utils/dummy_data.dart';
import '../widgets/train_card.dart';
import 'train_details_screen.dart';

class TrainListScreen extends StatelessWidget {
  final String from;
  final String to;
  final DateTime date;

  const TrainListScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, we would filter DummyData.trains based on 'from' and 'to'
    final filteredTrains = DummyData.trains;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              '$from to $to',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('EEE, d MMM').format(date),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {
              // Filter logic
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredTrains.length} trains found',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort_rounded, size: 18),
                  label: const Text('Sort by Price'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredTrains.length,
              itemBuilder: (context, index) {
                final train = filteredTrains[index];
                return Hero(
                  tag: 'train_${train.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: TrainCard(
                      train: train,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainDetailsScreen(train: train),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
