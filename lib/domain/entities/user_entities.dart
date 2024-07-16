import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  // final Address address;
  final int id;
  final String email;
  final String username;
  final String password;
  // final Name name;
  final int v;

  const UserEntities({
    // required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    // required this.name,
    required this.v,
  });

  @override
  List<Object?> get props => [
        // address,
        id,
        email,
        username,
        password,
        // name,
        v,
      ];
}

// class Address {
//   Geolocation geolocation;
//   String city;
//   String street;
//   int number;
//   String zipcode;

//   Address({
//     required this.geolocation,
//     required this.city,
//     required this.street,
//     required this.number,
//     required this.zipcode,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'geolocation': geolocation,
//       'city': city,
//       'street': street,
//       'number': number,
//       'zipcode': zipcode,
//     };
//   }

//   factory Address.fromMap(Map<String, dynamic> map) {
//     return Address(
//       geolocation: Geolocation(
//         lat: map['geolocation']['lat'],
//         long: map['geolocation']['long'],
//       ),
//       city: map['city'],
//       street: map['street'],
//       number: map['number'],
//       zipcode: map['zipcode'],
//     );
//   }
// }

// class Geolocation {
//   String lat;
//   String long;

//   Geolocation({
//     required this.lat,
//     required this.long,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'lat': lat,
//       'long': long,
//     };
//   }

//   factory Geolocation.fromMap(Map<String, dynamic> map) {
//     return Geolocation(
//       lat: map['lat'],
//       long: map['long'],
//     );
//   }
// }

// class Name {
//   String firstname;
//   String lastname;

//   Name({
//     required this.firstname,
//     required this.lastname,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'firstname': firstname,
//       'lastname': lastname,
//     };
//   }

//   factory Name.fromMap(Map<String, dynamic> map) {
//     return Name(
//       firstname: map['firstname'],
//       lastname: map['lastname'],
//     );
//   }
// }
