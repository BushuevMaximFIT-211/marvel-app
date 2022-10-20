class HeroMarvel {
  final String name;
  final int id;
  final String path;

  const HeroMarvel({required this.id, required this.name, required this.path});

  factory HeroMarvel.fromJson(Map<String, dynamic> json) {
    return HeroMarvel(
        name: json['name'], id: json['id'], path: json['thumbnail']['path']);
  }
}
