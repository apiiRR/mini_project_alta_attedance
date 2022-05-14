class Data {
  String id, duration, userId, checkIn, checkOut, status, doc;

  Data(
      {required this.checkIn,
      required this.checkOut,
      required this.duration,
      required this.id,
      required this.userId,
      required this.status,
      required this.doc});

  Map toJson() => {
        'checkIn': checkIn,
        'checkOut': checkOut,
        'duration': duration,
        'userId': userId,
        'status': "hadir",
        'doc': ""
      };

  Map sakitToJson() => {
        'checkIn': checkIn,
        'checkOut': "",
        'duration': "",
        'userId': userId,
        'status': "sakit",
        'doc': doc,
      };

  Map cutiToJson() => {
        'checkIn': checkIn,
        'checkOut': "",
        'duration': "",
        'userId': userId,
        'status': "cuti",
        'doc': "",
      };

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        userId: parsedJson['userId'],
        id: parsedJson['id'],
        checkIn: parsedJson['checkIn'],
        checkOut: parsedJson['checkOut'],
        duration: parsedJson['duration'],
        status: parsedJson['status'],
        doc: parsedJson['doc']);
  }
}
