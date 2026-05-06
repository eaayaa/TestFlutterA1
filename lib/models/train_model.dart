class Train {
  final String id;
  final String name;
  final String number;
  final List<String> classes;
  final double basePrice;
  final List<RouteStop> schedule;
  final String duration;

  Train({
    required this.id,
    required this.name,
    required this.number,
    required this.classes,
    required this.basePrice,
    required this.schedule,
    required this.duration,
  });

  RouteStop get departure => schedule.first;
  RouteStop get arrival => schedule.last;
}

class RouteStop {
  final String stationName;
  final DateTime time;

  RouteStop({
    required this.stationName,
    required this.time,
  });
}

class Station {
  final String name;
  final String city;
  final String code;

  Station({
    required this.name,
    required this.city,
    required this.code,
  });
}

class Booking {
  final String id;
  final Train train;
  final DateTime travelDate;
  final String selectedClass;
  final List<Passenger> passengers;
  final List<String> selectedSeats;

  Booking({
    required this.id,
    required this.train,
    required this.travelDate,
    required this.selectedClass,
    required this.passengers,
    required this.selectedSeats,
  });
}

class Passenger {
  final String name;
  final String email;
  final String phone;

  Passenger({
    required this.name,
    required this.email,
    required this.phone,
  });
}
