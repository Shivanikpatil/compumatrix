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
class VehicleModel {
  final String id;
  final String regNo;
  final String vehicleName;
  final String vehicleType;
  final List<String> vehicleImage;
  final String createdAt;

  VehicleModel({
    required this.id,
    required this.regNo,
    required this.vehicleName,
    required this.vehicleType,
    required this.vehicleImage,
    required this.createdAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id']?.toString() ?? '',
      regNo: json['reg_no']?.toString() ?? '',
      vehicleName: json['vehicle_name']?.toString() ?? '',
      vehicleType: json['vehicle_type']?.toString() ?? '',
      vehicleImage: (json['vehicle_image'] is List)
          ? List<String>.from(
          (json['vehicle_image'] as List).map((e) => e?.toString() ?? ''))
          : [],
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  bool get isTwoWheeler => vehicleType == 'two_wheeler';

  String get displayName =>
      vehicleName.trim().isEmpty ? 'Unknown Vehicle' : vehicleName.trim();
}