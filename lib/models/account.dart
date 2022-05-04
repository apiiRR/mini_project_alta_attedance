class Account {
  String id, name, email, password, nip, job;
  DateTime createdAt;

  Account({required this.id, required this.name, required this.email, required this.password, required this.createdAt, required this.nip, required this.job});

  Map toJson() => {'name' : name, 'email' : email.toLowerCase(), 'password' : password, 'nip' : nip, 'job' : job, 'createdAt' : createdAt.toString()};
}