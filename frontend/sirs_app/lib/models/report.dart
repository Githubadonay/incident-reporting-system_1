class Report {
  final String id;
  final String description;
  final String location;
  final DateTime date;
  final String? imageUrl;

  Report({
    required this.id,
    required this.description,
    required this.location,
    required this.date,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'location': location,
    'date': date.toIso8601String(),
    'imageUrl': imageUrl,
  };
}
