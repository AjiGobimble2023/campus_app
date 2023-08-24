class RegisterModel {
  final String fullName;
  final String email;
  final String password;
  final String birthDate;
  final String address;
  final String phoneNumber;
  final String campusName;
  final String city;
  final String? imageUrl;

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.address,
    required this.phoneNumber,
    required this.campusName,
    required this.city,
    this.imageUrl,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      birthDate: json['birthDate'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      campusName: json['campus_name'],
      city: json['city'],
      imageUrl: json['image_url']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'birthDate': birthDate,
      'address': address,
      'phoneNumber': phoneNumber,
      'campus_name': campusName,
      'city': city
    };
  }
}