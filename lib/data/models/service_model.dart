
class ActiveService {
  final String id;
  final String vehicleName;
  final String regNo;
  final String imageUrl;

  ActiveService({
    required this.id,
    required this.vehicleName,
    required this.regNo,
    required this.imageUrl,
  });

  factory ActiveService.fromJson(
      Map<String, dynamic> json) {
    return ActiveService(
      id: json['_id'] ?? '',
      vehicleName:
      json['serviceTitle'] ?? '',
      regNo: json['slug'] ?? '',
      imageUrl:
      (json['serviceImages'] != null &&
          json['serviceImages']
              .isNotEmpty)
          ? json['serviceImages'][0]
          : '',
    );
  }
}


// lib/models/service_model.dart

class Category {
  final String id;
  final String title;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class ServiceFeature {
  final String title;
  final String? icon;

  ServiceFeature({required this.title, this.icon});

  factory ServiceFeature.fromJson(Map<String, dynamic> json) {
    return ServiceFeature(
      title: json['title'] ?? '',
      icon: json['icon'],
    );
  }
}

class ServiceModel {
  final String id;
  final Category category;
  final String serviceTitle;
  final String serviceDescription;
  final List<ServiceFeature> serviceFeature;
  final List<String> serviceImages;
  final List<String> serviceInclusions;
  final List<String> serviceBefore;
  final List<String> serviceAfter;
  final List<String> howServiceWorks;
  final double price;
  final double totalAmount;
  final double tax;
  final String priceType;
  final String duration;
  final String slug;
  final bool isActive;
  final bool isVehicle;

  ServiceModel({
    required this.id,
    required this.category,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.serviceFeature,
    required this.serviceImages,
    required this.serviceInclusions,
    required this.serviceBefore,
    required this.serviceAfter,
    required this.howServiceWorks,
    required this.price,
    required this.totalAmount,
    required this.tax,
    required this.priceType,
    required this.duration,
    required this.slug,
    required this.isActive,
    required this.isVehicle,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      category: Category.fromJson(json['category'] ?? {}),
      serviceTitle: json['serviceTitle'] ?? '',
      serviceDescription: json['serviceDescription'] ?? '',
      serviceFeature: (json['serviceFeature'] as List<dynamic>? ?? [])
          .map((e) => ServiceFeature.fromJson(e))
          .toList(),
      serviceImages: List<String>.from(json['serviceImages'] ?? []),
      serviceInclusions: List<String>.from(json['serviceInclusions'] ?? []),
      serviceBefore: List<String>.from(json['serviceBefore'] ?? []),
      serviceAfter: List<String>.from(json['serviceAfter'] ?? []),
      howServiceWorks: List<String>.from(json['howServiceWorks'] ?? []),
      price: (json['price'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      priceType: json['priceType'] ?? '',
      duration: json['duration'] ?? '',
      slug: json['slug'] ?? '',
      isActive: json['isActive'] ?? false,
      isVehicle: json['isVehicle'] ?? false,
    );
  }
}
