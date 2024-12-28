class Plan {
  int id;
  int packageId;
  String mode;
  double price;
  DateTime createdAt;
  DateTime updatedAt;

  Plan({
    required this.id,
    required this.packageId,
    required this.mode,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  // Parse JSON data for Plan
  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      packageId: json['package_id'],
      mode: json['mode'],
      price: (json['price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert Plan object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_id': packageId,
      'mode': mode,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Package {
  int id;
  String name;
  int ageFrom;
  int ageTo;
  List<Plan> plans;
  String? image;

  Package({
    required this.id,
    required this.name,
    required this.ageFrom,
    required this.ageTo,
    required this.plans,
    this.image,
  });

  // Parse JSON data for Package
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      ageFrom: json['age_from'],
      ageTo: json['age_to'],
      plans:
          (json['plans'] as List).map((plan) => Plan.fromJson(plan)).toList(),
      image: json['image'],
    );
  }

  // Convert Package object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age_from': ageFrom,
      'age_to': ageTo,
      'plans': plans.map((plan) => plan.toJson()).toList(),
      'image': image,
    };
  }
}

// Function to parse entire response
class PackageResponse {
  bool? status;
  List<Package> data;

  PackageResponse({
    required this.status,
    required this.data,
  });

  factory PackageResponse.fromJson(Map<String, dynamic> json) {
    return PackageResponse(
      status: json['status'],
      data:
          (json['data'] as List).map((item) => Package.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((package) => package.toJson()).toList(),
    };
  }
}
