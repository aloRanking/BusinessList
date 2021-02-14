import 'dart:convert';

class Business {
  String name;
  String email;
  String address;
  String type;
  bool isActive;
  var coordinates;
  String imgurl;
  
  Business({
    this.name,
    this.email,
    this.address,
    this.type,
    this.isActive,
    this.coordinates,
    this.imgurl,
  });


  Business copyWith({
    String name,
    String email,
    String address,
    String type,
    bool isActive,
    var coordinates,
    String imgurl,
  }) {
    return Business(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      coordinates: coordinates ?? this.coordinates,
      imgurl: imgurl ?? this.imgurl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'type': type,
      'isActive': isActive,
      'coordinates': coordinates?.toMap(),
      'imgurl': imgurl,
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
      coordinates: List.from(map['coordinates']),
      imgurl: map['imgurl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Business.fromJson(String source) =>
      Business.fromMap(json.decode(source));


  @override
  String toString() {
    return 'Business(name: $name, email: $email, address: $address, type: $type, isActive: $isActive, coordinates: $coordinates, imgurl: $imgurl)';
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
        o.coordinates == coordinates &&
        o.imgurl == imgurl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    email.hashCode ^
    address.hashCode ^
    type.hashCode ^
    isActive.hashCode ^
    coordinates.hashCode ^
    imgurl.hashCode;
  }
}
