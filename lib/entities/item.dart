class Item {
  final String id;
  final String name;
  final String type;
  final int points;

  const Item(this.id, this.name, this.type, this.points);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['_id'],
      json['name'],
      json['type'],
      json['points'],
    );
  }

  toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'points': points,
    };
  }
}
