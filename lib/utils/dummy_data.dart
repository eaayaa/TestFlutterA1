import '../models/train_model.dart';

class DummyData {
  static List<Station> stations = [
    Station(name: 'Grand Central', city: 'New York', code: 'NYG'),
    Station(name: 'Union Station', city: 'Washington D.C.', code: 'WAS'),
    Station(name: 'South Station', city: 'Boston', code: 'BOS'),
    Station(name: '30th Street Station', city: 'Philadelphia', code: 'PHL'),
    Station(name: 'Union Station', city: 'Chicago', code: 'CHI'),
    Station(name: 'Union Station', city: 'Los Angeles', code: 'LAX'),
  ];

  static List<Train> trains = [
    Train(
      id: '1',
      name: 'Acela Express',
      number: '2150',
      classes: ['Economy', 'Business', 'First Class'],
      basePrice: 120.0,
      duration: '3h 30m',
      schedule: [
        RouteStop(stationName: 'New York', time: DateTime(2024, 10, 10, 8, 0)),
        RouteStop(stationName: 'Washington D.C.', time: DateTime(2024, 10, 10, 11, 30)),
      ],
    ),
    Train(
      id: '2',
      name: 'Northeast Regional',
      number: '172',
      classes: ['Economy', 'Business'],
      basePrice: 85.0,
      duration: '4h 15m',
      schedule: [
        RouteStop(stationName: 'Boston', time: DateTime(2024, 10, 10, 9, 15)),
        RouteStop(stationName: 'New York', time: DateTime(2024, 10, 10, 13, 30)),
      ],
    ),
    Train(
      id: '3',
      name: 'Empire Service',
      number: '233',
      classes: ['Economy', 'Business'],
      basePrice: 65.0,
      duration: '2h 45m',
      schedule: [
        RouteStop(stationName: 'New York', time: DateTime(2024, 10, 10, 10, 0)),
        RouteStop(stationName: 'Albany', time: DateTime(2024, 10, 10, 12, 45)),
      ],
    ),
    Train(
      id: '4',
      name: 'Pacific Surfliner',
      number: '765',
      classes: ['Economy', 'Business'],
      basePrice: 45.0,
      duration: '2h 50m',
      schedule: [
        RouteStop(stationName: 'Los Angeles', time: DateTime(2024, 10, 10, 14, 30)),
        RouteStop(stationName: 'San Diego', time: DateTime(2024, 10, 10, 17, 20)),
      ],
    ),
  ];

  static List<String> popularRoutes = [
    'New York to Washington D.C.',
    'Boston to New York',
    'Los Angeles to San Diego',
    'Chicago to Milwaukee',
  ];
}
