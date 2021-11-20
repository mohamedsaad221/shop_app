// @dart=2.9

class CategoriesModel {
  bool status;
  CategoriesDateModel data;

  CategoriesModel.fromJson(Map<String , dynamic> json) {
    status = json['status'];
    data = CategoriesDateModel.fromJson(json['data']);
  }

}

class CategoriesDateModel {
    int currentPage;
    List<DataModel> data = [];
    CategoriesDateModel.fromJson(Map<String , dynamic> json) {
      currentPage = json['current_page'];
      json['data'].forEach((element) {
        data.add(DataModel.fromJson(element));
      });
    }
}

class DataModel {
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String , dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}