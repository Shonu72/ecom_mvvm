import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  int v;

  UserEntities({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.v,
  });

  @override
  List<Object?> get props => [
        address,
        id,
        email,
        username,
        password,
        name,
        v,
      ];
}

class Address {
  Geolocation geolocation;
  String city;
  String street;
  int number;
  String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });
}

class Geolocation {
  String lat;
  String long;

  Geolocation({
    required this.lat,
    required this.long,
  });
}

class Name {
  String firstname;
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });
}
