// @dart=2.9

class ChangeFavModel {
  bool status;
  String message;

  ChangeFavModel.fromJson(Map<String , dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}