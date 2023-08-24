import 'dart:io';

class UpdateProfileModel {
  final String fullName;
  final String birthDate;
  final String address;
  final String phoneNumber;
  final String campusName;
  final String city;
  final File? image;

  UpdateProfileModel(
      {required this.fullName,
      required this.birthDate,
      required this.address,
      required this.phoneNumber,
      required this.campusName,
      required this.city,
      this.image});


  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'birthDate': birthDate,
      'address': address,
      'phoneNumber': phoneNumber,
      'campus_name': campusName,
      'city': city,
      'image': image
    };
  }
}
