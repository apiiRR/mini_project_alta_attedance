class Account {
  String id, name, email, password;
  DateTime createdAt;

  Account({required this.id, required this.name, required this.email, required this.password, required this.createdAt});

  Map toJson() => {'name' : name, 'email' : email, 'password' : password, 'createdAt' : createdAt.toString()};
}