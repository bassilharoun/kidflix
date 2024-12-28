class CategoryResponse {
  bool? status;
  List<Category>? data;

  CategoryResponse({
    required this.status,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      data: json['data'] != null 
          ? List<Category>.from(
              (json['data'] as List).map((item) => Category.fromJson(item))
            )
          : null, // Handle null case for data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data != null
          ? List<dynamic>.from(data!.map((item) => item.toJson()))
          : null, // Ensure to handle null data case in toJson as well
    };
  }
}

class Category {
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '', // Handle null image with a default value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
