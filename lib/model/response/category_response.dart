class CategoryResponse {
  bool? status;
  String? message;
  String? baseUrl;
  List<Data>? data;

  CategoryResponse({this.status, this.message, this.data, this.baseUrl});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    baseUrl = json['base_url'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['base_url'] = this.baseUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? slug;
  String? menuId;
  String? parent;
  String? leval;
  String? description;
  String? image;
  String? status;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.menuId,
      this.parent,
      this.leval,
      this.description,
      this.image,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    menuId = json['menu_id'];
    parent = json['parent'];
    leval = json['leval'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['menu_id'] = this.menuId;
    data['parent'] = this.parent;
    data['leval'] = this.leval;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
