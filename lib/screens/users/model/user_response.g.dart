// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserResponseAdapter extends TypeAdapter<UserResponse> {
  @override
  final int typeId = 0;

  @override
  UserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResponse(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      maidenName: fields[3] as String?,
      age: fields[4] as int?,
      gender: fields[5] as String?,
      email: fields[6] as String?,
      phone: fields[7] as String?,
      username: fields[8] as String?,
      password: fields[9] as String?,
      birthDate: fields[10] as String?,
      image: fields[11] as String?,
      bloodGroup: fields[12] as String?,
      height: fields[13] as double?,
      weight: fields[14] as double?,
      eyeColor: fields[15] as String?,
      hair: fields[16] as Hair?,
      ip: fields[17] as String?,
      address: fields[18] as Address?,
      macAddress: fields[19] as String?,
      university: fields[20] as String?,
      bank: fields[21] as Bank?,
      company: fields[22] as Company?,
      ein: fields[23] as String?,
      ssn: fields[24] as String?,
      userAgent: fields[25] as String?,
      crypto: fields[26] as Crypto?,
      role: fields[27] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserResponse obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.maidenName)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.birthDate)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.bloodGroup)
      ..writeByte(13)
      ..write(obj.height)
      ..writeByte(14)
      ..write(obj.weight)
      ..writeByte(15)
      ..write(obj.eyeColor)
      ..writeByte(16)
      ..write(obj.hair)
      ..writeByte(17)
      ..write(obj.ip)
      ..writeByte(18)
      ..write(obj.address)
      ..writeByte(19)
      ..write(obj.macAddress)
      ..writeByte(20)
      ..write(obj.university)
      ..writeByte(21)
      ..write(obj.bank)
      ..writeByte(22)
      ..write(obj.company)
      ..writeByte(23)
      ..write(obj.ein)
      ..writeByte(24)
      ..write(obj.ssn)
      ..writeByte(25)
      ..write(obj.userAgent)
      ..writeByte(26)
      ..write(obj.crypto)
      ..writeByte(27)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HairAdapter extends TypeAdapter<Hair> {
  @override
  final int typeId = 1;

  @override
  Hair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hair(
      color: fields[0] as String?,
      type: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hair obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 2;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      address: fields[0] as String?,
      city: fields[1] as String?,
      state: fields[2] as String?,
      stateCode: fields[3] as String?,
      postalCode: fields[4] as String?,
      coordinates: fields[5] as Coordinates?,
      country: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.stateCode)
      ..writeByte(4)
      ..write(obj.postalCode)
      ..writeByte(5)
      ..write(obj.coordinates)
      ..writeByte(6)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinatesAdapter extends TypeAdapter<Coordinates> {
  @override
  final int typeId = 3;

  @override
  Coordinates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coordinates(
      lat: fields[0] as double?,
      lng: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Coordinates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankAdapter extends TypeAdapter<Bank> {
  @override
  final int typeId = 4;

  @override
  Bank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bank(
      cardExpire: fields[0] as String?,
      cardNumber: fields[1] as String?,
      cardType: fields[2] as String?,
      currency: fields[3] as String?,
      iban: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bank obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardExpire)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.iban);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  final int typeId = 5;

  @override
  Company read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Company(
      department: fields[0] as String?,
      name: fields[1] as String?,
      title: fields[2] as String?,
      address: fields[3] as Address?,
    );
  }

  @override
  void write(BinaryWriter writer, Company obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.department)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CryptoAdapter extends TypeAdapter<Crypto> {
  @override
  final int typeId = 6;

  @override
  Crypto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Crypto(
      coin: fields[0] as String?,
      wallet: fields[1] as String?,
      network: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Crypto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.wallet)
      ..writeByte(2)
      ..write(obj.network);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
