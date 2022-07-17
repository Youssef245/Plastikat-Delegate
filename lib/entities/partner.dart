import 'common/address.dart';
import 'common/reward.dart';

class Partner {
  // ignore: unused_field
  final String id;
  final String name;
  final String? description;
  final List<Address>? branches;
  final List<Reward>? rewards;

  const Partner(
      this.id, this.name, this.description, this.branches, this.rewards);

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      json['_id'],
      json['name'],
      json['description'],
      json['branches'] != null
          ? (json['branches'] as List).map((i) => Address.fromJson(i)).toList()
          : null,
      json['rewards'] != null
          ? (json['rewards'] as List).map((i) => Reward.fromJson(
            i as Map<String, dynamic>
          )).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'branches': branches?.map((i) => i.toJson()).toList(),
      'rewards': rewards?.map((i) => i.toJson()).toList(),
    };
  }
}
