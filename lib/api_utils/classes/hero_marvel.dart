class HeroMarvel {
  final String name;

  final String path;
  final String info = '';

  const HeroMarvel({required this.name, required this.path});

  factory HeroMarvel.fromJson(Map<String, dynamic> json) {
    return HeroMarvel(name: json['name'], path: json['thumbnail']['path']);
  }
}
