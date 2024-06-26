
import 'package:hive/hive.dart';

part 'haive_model.g.dart';

@HiveType(typeId: 0)
class CatModelHive extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String origin;

  @HiveField(2)
  String image;

  CatModelHive({
    required this.name,
    required this.origin,
    required this.image,
  });


  factory CatModelHive.fromJson(Map<String, dynamic> json) {
    return CatModelHive(
      name: json['name'],
      origin: json['origin'],
      image: json['image'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'origin': origin,
      'image': image,
    };
  }

  CatModelHive copyWith({
    String? name,
    String? origin,
    String? image,
  }) {
    return CatModelHive(
      name: name ?? this.name,
      origin: origin ?? this.origin,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'origin': origin,
      'image': image,
    };
  }

  factory CatModelHive.fromMap(Map<String, dynamic> map) {
    return CatModelHive(
      name: map['name'] as String,
      origin: map['origin'] as String,
      image: map['image'] as String,
    );
  }



  @override
  String toString() => 'CatModelHive(name: $name, origin: $origin, image: $image)';

  @override
  bool operator ==(covariant CatModelHive other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.origin == origin &&
      other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ origin.hashCode ^ image.hashCode;
}
