class HomeBannerResponse {
  bool? status;
  String? message;
  String? baseUrl;
  List<Data>? data;

  HomeBannerResponse({this.status, this.message, this.data, this.baseUrl});

  HomeBannerResponse.fromJson(Map<String, dynamic> json) {
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
  String? sliderTitle;
  String? sliderUrl;
  String? sliderImage;
  String? subCat;
  String? sliderStatus;

  Data(
      {this.id,
      this.sliderTitle,
      this.sliderUrl,
      this.sliderImage,
      this.subCat,
      this.sliderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderTitle = json['slider_title'];
    sliderUrl = json['slider_url'];
    sliderImage = json['slider_image'];
    subCat = json['sub_cat'];
    sliderStatus = json['slider_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slider_title'] = this.sliderTitle;
    data['slider_url'] = this.sliderUrl;
    data['slider_image'] = this.sliderImage;
    data['sub_cat'] = this.subCat;
    data['slider_status'] = this.sliderStatus;
    return data;
  }
}
