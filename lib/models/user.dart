class User {
  int id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int countOfReservations;
  bool isRemembered;

  User(
    this.id, {
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.countOfReservations = 0,
    this.isRemembered = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'countOfReservations': countOfReservations,
      'isRemembered': isRemembered,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      isRemembered: json['isRemembered'] as bool,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      countOfReservations: json['countOfReservations'] as int,
    );
  }
}
