class Account {
  String idUser, name, email, password, nip, job, id;
  DateTime createdAt;

  Account(
      {required this.idUser,
      required this.name,
      required this.email,
      required this.password,
      required this.createdAt,
      required this.nip,
      required this.job,
      required this.id});

  Map toJson() => {
        'name': name,
        'email': email.toLowerCase(),
        'password': password,
        'nip': nip,
        'job': job,
      };
}
