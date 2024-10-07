class CategoryResponse {
  bool status;
  List<Category> data;

  CategoryResponse({
    required this.status,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      data: List<Category>.from(
          json['data'].map((item) => Category.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
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
      image: json['image'],
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
