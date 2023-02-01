import 'dart:convert';
/// status : true
/// meassge : "Gallery Delete successfully"

DeleteImageModel deleteImageModelFromJson(String str) => DeleteImageModel.fromJson(json.decode(str));
String deleteImageModelToJson(DeleteImageModel data) => json.encode(data.toJson());
class DeleteImageModel {
  DeleteImageModel({
      bool? status, 
      String? meassge,}){
    _status = status;
    _meassge = meassge;
}

  DeleteImageModel.fromJson(dynamic json) {
    _status = json['status'];
    _meassge = json['meassge'];
  }
  bool? _status;
  String? _meassge;

  bool? get status => _status;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['meassge'] = _meassge;
    return map;
  }

}