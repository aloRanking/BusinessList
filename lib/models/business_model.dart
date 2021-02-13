import 'dart:convert';

class Business {
  String name;
  String email;
  String address;
  String type;
  bool isActive;
  String coordinates;

  Business({
    this.name,
    this.email,
    this.address,
    this.type,
    this.isActive,
    this.coordinates,
  });

  Business copyWith({
    String name,
    String email,
    String address,
    String type,
    bool isActive,
    String coordinates,
  }) {
    return Business(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'type': type,
      'isActive': isActive,
      'coordinates': coordinates,
    };
  }

  factory Business.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Business(
      name: map['name'],
      email: map['email'],
      address: map['address'],
      type: map['type'],
      isActive: map['isActive'],
      coordinates: map['coordinates'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Business.fromJson(String source) =>
      Business.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Business(name: $name, email: $email, address: $address, type: $type, isActive: $isActive, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Business &&
        o.name == name &&
        o.email == email &&
        o.address == address &&
        o.type == type &&
        o.isActive == isActive &&
        o.coordinates == coordinates;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        type.hashCode ^
        isActive.hashCode ^
        coordinates.hashCode;
  }
}
