import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/view/shimmer_loding_view/loding_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PrivacyPolicyView extends StatelessWidget {
  PrivacyPolicyView(this.type,this.title,{Key? key}) : super(key: key);
  late GetPageResponse response;
  String type,title;
  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
          future: getPrivacyPolicy(),
          builder: (context, snapshot) {
            print(snapshot.error);
            if (snapshot.hasError) {
              return Center(child: Text("Something Went Wrong"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LodingAllPage();
            }
            return SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: mysize.width / 40,
                      vertical: mysize.height / 60),
                  child: HtmlWidget(
                    response.data!.pgDescri.toString(),
                  )),
            );
          }),
    );
  }

  getPrivacyPolicy() async {
    response = await AuthApiHelper.getPrivacyPolicy(type);
    return response;
  }
}
class GetPageResponse {
  bool? status;
  Data? data;
  String? meassge;

  GetPageResponse({this.status, this.data, this.meassge});

  GetPageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meassge = json['meassge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['meassge'] = this.meassge;
    return data;
  }
}

class Data {
  String? id;
  String? pgTitle;
  String? pgSlug;
  String? pgDescri;
  String? pgStatus;
  String? pgFoot;
  String? cratedDate;

  Data(
      {this.id,
        this.pgTitle,
        this.pgSlug,
        this.pgDescri,
        this.pgStatus,
        this.pgFoot,
        this.cratedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pgTitle = json['pg_title'];
    pgSlug = json['pg_slug'];
    pgDescri = json['pg_descri'];
    pgStatus = json['pg_status'];
    pgFoot = json['pg_foot'];
    cratedDate = json['crated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pg_title'] = this.pgTitle;
    data['pg_slug'] = this.pgSlug;
    data['pg_descri'] = this.pgDescri;
    data['pg_status'] = this.pgStatus;
    data['pg_foot'] = this.pgFoot;
    data['crated_date'] = this.cratedDate;
    return data;
  }
}
