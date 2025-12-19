import 'package:hive/hive.dart';
part 'user_response.g.dart';

@HiveType(typeId: 0)
class UserResponse {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? maidenName;
  @HiveField(4)
  int? age;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? phone;
  @HiveField(8)
  String? username;
  @HiveField(9)
  String? password;
  @HiveField(10)
  String? birthDate;
  @HiveField(11)
  String? image;
  @HiveField(12)
  String? bloodGroup;
  @HiveField(13)
  double? height;
  @HiveField(14)
  double? weight;
  @HiveField(15)
  String? eyeColor;
  @HiveField(16)
  Hair? hair;
  @HiveField(17)
  String? ip;
  @HiveField(18)
  Address? address;
  @HiveField(19)
  String? macAddress;
  @HiveField(20)
  String? university;
  @HiveField(21)
  Bank? bank;
  @HiveField(22)
  Company? company;
  @HiveField(23)
  String? ein;
  @HiveField(24)
  String? ssn;
  @HiveField(25)
  String? userAgent;
  @HiveField(26)
  Crypto? crypto;
  @HiveField(27)
  String? role;

  UserResponse(
      {this.id,
        this.firstName,
        this.lastName,
        this.maidenName,
        this.age,
        this.gender,
        this.email,
        this.phone,
        this.username,
        this.password,
        this.birthDate,
        this.image,
        this.bloodGroup,
        this.height,
        this.weight,
        this.eyeColor,
        this.hair,
        this.ip,
        this.address,
        this.macAddress,
        this.university,
        this.bank,
        this.company,
        this.ein,
        this.ssn,
        this.userAgent,
        this.crypto,
        this.role});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = _toInt(json['age']);
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = _toDouble(json['height']);
    weight = _toDouble(json['weight']);
    eyeColor = json['eyeColor'];
    hair = json['hair'] != null ? new Hair.fromJson(json['hair']) : null;
    ip = json['ip'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    macAddress = json['macAddress'];
    university = json['university'];
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    ein = json['ein'];
    ssn = json['ssn'];
    userAgent = json['userAgent'];
    crypto =
    json['crypto'] != null ? new Crypto.fromJson(json['crypto']) : null;
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['maidenName'] = this.maidenName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['birthDate'] = this.birthDate;
    data['image'] = this.image;
    data['bloodGroup'] = this.bloodGroup;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eyeColor'] = this.eyeColor;
    if (this.hair != null) {
      data['hair'] = this.hair!.toJson();
    }
    data['ip'] = this.ip;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['macAddress'] = this.macAddress;
    data['university'] = this.university;
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['ein'] = this.ein;
    data['ssn'] = this.ssn;
    data['userAgent'] = this.userAgent;
    if (this.crypto != null) {
      data['crypto'] = this.crypto!.toJson();
    }
    data['role'] = this.role;
    return data;
  }
}

@HiveType(typeId: 1)
class Hair {
  @HiveField(0)
  String? color;
  @HiveField(1)
  String? type;

  Hair({this.color, this.type});

  Hair.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['type'] = this.type;
    return data;
  }
}

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  String? address;
  @HiveField(1)
  String? city;
  @HiveField(2)
  String? state;
  @HiveField(3)
  String? stateCode;
  @HiveField(4)
  String? postalCode;
  @HiveField(5)
  Coordinates? coordinates;
  @HiveField(6)
  String? country;

  Address(
      {this.address,
        this.city,
        this.state,
        this.stateCode,
        this.postalCode,
        this.coordinates,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateCode = json['stateCode'];
    postalCode = json['postalCode'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['stateCode'] = this.stateCode;
    data['postalCode'] = this.postalCode;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['country'] = this.country;
    return data;
  }
}

@HiveType(typeId: 3)
class Coordinates {
  @HiveField(0)
  double? lat;
  @HiveField(1)
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

@HiveType(typeId: 4)
class Bank {
  @HiveField(0)
  String? cardExpire;
  @HiveField(1)
  String? cardNumber;
  @HiveField(2)
  String? cardType;
  @HiveField(3)
  String? currency;
  @HiveField(4)
  String? iban;

  Bank(
      {this.cardExpire,
        this.cardNumber,
        this.cardType,
        this.currency,
        this.iban});

  Bank.fromJson(Map<String, dynamic> json) {
    cardExpire = json['cardExpire'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    currency = json['currency'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardExpire'] = this.cardExpire;
    data['cardNumber'] = this.cardNumber;
    data['cardType'] = this.cardType;
    data['currency'] = this.currency;
    data['iban'] = this.iban;
    return data;
  }
}

@HiveType(typeId: 5)
class Company {
  @HiveField(0)
  String? department;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? title;
  @HiveField(3)
  Address? address;

  Company({this.department, this.name, this.title, this.address});

  Company.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    title = json['title'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department'] = this.department;
    data['name'] = this.name;
    data['title'] = this.title;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 6)
class Crypto {
  @HiveField(0)
  String? coin;
  @HiveField(1)
  String? wallet;
  @HiveField(2)
  String? network;

  Crypto({this.coin, this.wallet, this.network});

  Crypto.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    wallet = json['wallet'];
    network = json['network'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coin'] = this.coin;
    data['wallet'] = this.wallet;
    data['network'] = this.network;
    return data;
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}