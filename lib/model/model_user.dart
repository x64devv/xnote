class UserModel {
  int? id;
  final String name;
  final String pin;

  UserModel({this.id,required this.name, required this.pin});

  String get getName {
    return name;
  }

  String get getPin {
    return pin;
  }

  dynamic get getId {
    return id;
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "pin": pin};
  }
}
