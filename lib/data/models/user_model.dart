class UserModel {
  final String name;
  final String email;
  final String number;
  final int age;
  final double height;
  final double weight;
  final String sex;

  UserModel({
    required this.name,
    required this.email,
    required this.number,
    required this.age,
    required this.height,
    required this.weight,
    required this.sex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      age: json['age'] ?? 0,
      height: json['height'] ?? 0.0,
      weight: json['weight'] ?? 0.0,
      sex: json['sex'] ?? 'Male',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'age': age,
      'height': height,
      'weight': weight,
      'sex': sex,
    };
  }
}
