class Account {
  String idUser, name, email, password, nip, job, id, photo;
  DateTime createdAt;

  Account(
      {required this.idUser,
      required this.name,
      required this.email,
      required this.password,
      required this.createdAt,
      required this.nip,
      required this.job,
      required this.id, 
      required this.photo});

  Map toJson() => {
        'name': name,
        'email': email.toLowerCase(),
        'password': password,
        'nip': nip,
        'job': job,
        'idUser' : idUser,
        'photo' : photo,
        'createdAt' : createdAt.toIso8601String(),
      };
}