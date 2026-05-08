// lib/data/models/vehicle_model.dart
class VehicleModel {
  final String id;
  final String regNo;
  final String vehicleName;
  final String vehicleType;   // "two_wheeler" | "four_wheeler"
  final List<String> vehicleImage;

  VehicleModel({
    required this.id,
    required this.regNo,
    required this.vehicleName,
    required this.vehicleType,
    required this.vehicleImage,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id'] as String? ?? '',
      regNo: json['reg_no'] as String? ?? '',
      vehicleName: json['vehicle_name'] as String? ?? '',
      vehicleType: json['vehicle_type'] as String? ?? '',
      vehicleImage: List<String>.from(json['vehicle_image'] ?? []),
    );
  }

  /// Full image URL ready for CachedNetworkImage
  String get primaryImageUrl {
    if (vehicleImage.isEmpty) return '';
    return 'https://wa-peke-api.demohub.tech/${vehicleImage.first}';
  }

  /// Display-friendly label
  String get typeLabel =>
      vehicleType == 'two_wheeler' ? 'Two Wheeler' : 'Four Wheeler';
}
