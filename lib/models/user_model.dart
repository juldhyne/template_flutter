class User {
  final int id;
  final String firstname;
  final String lastname;

  const User({required this.id, required this.firstname, required this.lastname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstName'],
      lastname: json['lastName'],
    );
  }
}
