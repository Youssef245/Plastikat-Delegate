class Delegate {
  final String id;
  final String name;
  final String email;
  final double rating;
  final String company;
  final String? phone;
  final String? gender;
  final String? birthDate;

  const Delegate(this.id, this.name, this.email, this.rating, this.company,
      this.phone, this.gender, this.birthDate);

  factory Delegate.fromJson(Map<String, dynamic> json) {
    return Delegate(
      json['_id'],
      json['name'],
      json['email'],
      json['rating'],
      json['company'],
      json['phone'] != null ? json['phone_number'] : null,
      json['gender'] != null ? json['gender'] : null,
      json['birth_date'] != null ? json['birth_date'] : null,
    );
  }

  // create toJson Method
  toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'rating': rating,
      'company': company,
      'phone_number': phone,
      'gender': gender,
    };
  }
}
