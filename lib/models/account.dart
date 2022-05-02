class Account {
  String id, name, email, password, phone, job;
  DateTime createdAt;

  Account({required this.id, required this.name, required this.email, required this.password, required this.createdAt, required this.phone, required this.job});

  Map toJson() => {'name' : name, 'email' : email.toLowerCase(), 'password' : password, 'createdAt' : createdAt.toString()};
}