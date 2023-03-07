class Product {
  int? id;
  String? title;
  String? description;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Product(
      {this.id,
      this.title,
      this.description,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }
}
