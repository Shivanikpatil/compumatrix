class Vehicle {
  final String id;
  final String regNo;
  final String vehicleType;
  final String vehicleName;
  final String? imageUrl;

  Vehicle({
    required this.id,
    required this.regNo,
    required this.vehicleType,
    required this.vehicleName,
    this.imageUrl,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id']?.toString() ?? '',
      regNo: json['reg_no'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
      vehicleName: json['vehicle_name'] ?? '',
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reg_no': regNo,
      'vehicle_type': vehicleType,
      'vehicle_name': vehicleName,
    };
  }
}
