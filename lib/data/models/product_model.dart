import 'package:ecom_mvvm/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: double.parse(map['price'].toString()),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      rating: Rating.fromJson(map['rating']),
    );
  }

  // static String _categoryToString(Category category) {
  //   switch (category) {
  //     case Category.ELECTRONICS:
  //       return 'ELECTRONICS';
  //     case Category.JEWELERY:
  //       return 'JEWELRY';
  //     case Category.MEN_S_CLOTHING:
  //       return 'MEN\'S_CLOTHING';
  //     case Category.WOMEN_S_CLOTHING:
  //       return 'WOMEN_S_CLOTHING';
  //     default:
  //       throw ArgumentError('Unknown category: $category');
  //   }
  // }

  // static Category _categoryFromString(String category) {
  //   switch (category) {
  //     case 'ELECTRONICS':
  //       return Category.ELECTRONICS;
  //     case 'JEWELERY':
  //       return Category.JEWELERY;
  //     case 'MEN\'S_CLOTHING':
  //       return Category.MEN_S_CLOTHING;
  //     case 'WOMEN_S_CLOTHING':
  //       return Category.WOMEN_S_CLOTHING;
  //     default:
  //       throw ArgumentError('Unknown category: $category');
  //   }
  // }
}
