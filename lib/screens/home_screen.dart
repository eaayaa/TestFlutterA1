import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../utils/dummy_data.dart';
import 'train_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String departureCity = 'New York';
  String destinationCity = 'Washington D.C.';
  DateTime travelDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: travelDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => travelDate = picked);
  }

  void _swapCities() {
    setState(() {
      final temp = departureCity;
      departureCity = destinationCity;
      destinationCity = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeader(),
                Positioned(
                  top: 180,
                  left: 24,
                  right: 24,
                  child: _buildSearchCard(),
                ),
              ],
            ),
            const SizedBox(height: 380), // Space for search card
            _buildPopularRoutes(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF8C00), Color(0xFFFFA726)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: 20,
            child: Opacity(
              opacity: 0.3,
              child: Lottie.network(
                'https://assets9.lottiefiles.com/packages/lf20_5njp3vgg.json',
                width: 280,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.map_rounded, size: 200, color: Colors.white24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, Explorer!',
                  style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Where to go?',
                  style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLocationInput(
            label: 'Departure city',
            city: departureCity,
            icon: Icons.location_on_rounded,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Colors.grey[200], height: 1),
              ),
              InkWell(
                onTap: _swapCities,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C00).withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const Icon(Icons.swap_vert_rounded, color: Color(0xFFFF8C00), size: 24),
                ),
              ),
            ],
          ),
          _buildLocationInput(
            label: 'Destination city',
            city: destinationCity,
            icon: Icons.train_rounded,
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, color: Color(0xFFFF8C00), size: 22),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Travel date', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      Text(
                        DateFormat('EEE, d MMM yyyy').format(travelDate),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainListScreen(from: departureCity, to: destinationCity, date: travelDate),
                ),
              );
            },
            child: const Text('Search Trains'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quick search: ', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              _buildQuickSearchTag('NYC'),
              _buildQuickSearchTag('WASH'),
              _buildQuickSearchTag('BOS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSearchTag(String city) {
    return GestureDetector(
      onTap: () {
        setState(() {
          destinationCity = city == 'NYC' ? 'New York' : (city == 'WASH' ? 'Washington D.C.' : 'Boston');
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          city,
          style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLocationInput({required String label, required String city, required IconData icon}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.orange.withOpacity(0.08), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFFFF8C00), size: 24),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            Text(city, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularRoutes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Routes',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: DummyData.popularRoutes.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final route = DummyData.popularRoutes[index];
                final cities = route.split(' to ');
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainListScreen(
                          from: cities[0],
                          to: cities[1],
                          date: DateTime.now(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 240,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: Colors.grey[100]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.trending_up_rounded, color: Colors.orange, size: 20),
                        ),
                        const Spacer(),
                        Text(cities[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const Icon(Icons.arrow_right_alt_rounded, color: Colors.orange, size: 22),
                        Text(cities[1], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 12),
                        Text(
                          'Starting at \$45',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
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
