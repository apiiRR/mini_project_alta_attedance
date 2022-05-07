class Data {
  String id;
  DateTime checkIn, checkOut;
  int duration;

  Data({required this.checkIn, required this.checkOut, required this.duration, required this.id});

  Map toJson() => {'checkIn': checkIn, 'checkOut': checkOut, 'duration' : duration};

    factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        id: parsedJson['id'],
        checkIn: parsedJson['check'],
        checkOut: parsedJson['name'],
        duration: parsedJson['phone']);
  }
}