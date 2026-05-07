class ActiveService {
  final String id;
  final String name;
  final String? description;
  final String? status;
  final String? date;

  ActiveService({
    required this.id,
    required this.name,
    this.description,
    this.status,
    this.date,
  });

  factory ActiveService.fromJson(Map<String, dynamic> json) {
    return ActiveService(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      status: json['status'],
      date: json['date'],
    );
  }
}
