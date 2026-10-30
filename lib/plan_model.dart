class TravelPlan {
  final String id;
  final String destination;
  final String date;
  final String createdBy;
  final String pickupPoint;

  TravelPlan({
    required this.id,
    required this.destination,
    required this.date,
    required this.createdBy,
    required this.pickupPoint,
  });

  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'date': date,
      'createdBy': createdBy,
      'pickupPoint': pickupPoint,
    };
  }

  factory TravelPlan.fromMap(Map<String, dynamic> map, String id) {
    return TravelPlan(
      id: id,
      destination: map['destination'] ?? '',
      date: map['date'] ?? '',
      createdBy: map['createdBy'] ?? '',
      pickupPoint: map['pickupPoint'] ?? 'Not specified',
    );
  }
}