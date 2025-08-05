// simple class holding the reports in Json format so it can be pulled by nodejs
// store a id, decription, location, date, img(file)
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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json['id'] as String,
    description: json['description'] as String,
    location: json['location'] as String,
    date: DateTime.parse(json['date'] as String),
    imageUrl: json['imageUrl'] as String?,
  );
}
