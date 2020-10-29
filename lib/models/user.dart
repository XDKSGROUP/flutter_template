import 'package:meta/meta.dart';

class User {
  final String name;
  final String imageUrl;
  final String backgroundImageUrl;
  final String email;

  const User({
    @required this.name,
    this.imageUrl,
    this.backgroundImageUrl,
    this.email,
  });
}
