class Data {
  String id, duration, userId, checkIn, checkOut;

  Data(
      {required this.checkIn,
      required this.checkOut,
      required this.duration,
      required this.id,
      required this.userId});

  Map toJson() => {
        'checkIn': checkIn,
        'checkOut': checkOut,
        'duration': duration,
        'userId': userId
      };

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        userId: parsedJson['userId'],
        id: parsedJson['id'],
        checkIn: parsedJson['checkIn'],
        checkOut: parsedJson['checkOut'],
        duration: parsedJson['duration']);
  }
}
