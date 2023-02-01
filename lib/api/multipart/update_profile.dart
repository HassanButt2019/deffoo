import 'dart:convert';

import 'package:deffo/Eco_Host/Create_festival/festival_parts/add_festival_days.dart';
import 'package:deffo/model/AddAccountModel.dart';
import 'package:deffo/model/AddFestivalAccountModel.dart';
import 'package:deffo/model/AddFestivalDaysModel.dart';
import 'package:deffo/model/BookingModal.dart';
import 'package:deffo/model/CreateCycleBrandsModel.dart';
import 'package:deffo/model/CreateCycleModel.dart';
import 'package:deffo/model/CreateFestivalDetailModel.dart';
import 'package:deffo/model/CreateFestivalThingsModel.dart';
import 'package:deffo/model/CreatePropertyModel.dart';
import 'package:deffo/model/CreateTourDetailsModel.dart';
import 'package:deffo/model/CreateTrackAccountsModel.dart';
import 'package:deffo/model/CreateTrackDayModel.dart';
import 'package:deffo/model/CreateTrackGeneralModel.dart';
import 'package:deffo/model/CreateTrackModel.dart';
import 'package:deffo/model/DeleteImageModel.dart';
import 'package:deffo/model/GetCycleBrandsModel.dart';
import 'package:deffo/model/GetCyclingListModel.dart';
import 'package:deffo/model/GetFestivalDaysModel.dart';
import 'package:deffo/model/GetFestivalListModel.dart';
import 'package:deffo/model/GetRoomMode.dart';
import 'package:deffo/model/GetTourListModel.dart';
import 'package:deffo/model/GetTrackDaysModel.dart';
import 'package:deffo/model/GetTrackModel.dart';
import 'package:deffo/model/PropertyImageModel.dart';
import 'package:deffo/model/PropertyListModel.dart';
import 'package:deffo/model/RoomDeleteModel.dart';
import 'package:deffo/model/SearchPropertyModel.dart';
import 'package:deffo/model/SetPropertyImageModel.dart';
import 'package:deffo/model/UpdatePropertyModel.dart';
import 'package:deffo/model/response/AddRoomModel.dart';
import 'package:deffo/model/response/UpdateProfileResponse.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
//update Profile
Future<UpdateProfileResponse?> updateProfile(
    userId, firstName, email, image,{String url=""}) async {
  if(image!=null){
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            url==""?'https://alphawizztest.tk/Deffo/api/authentication/editProfile':'https://alphawizztest.tk/Deffo/api/authentication/edithostProfile'));
    request.fields.addAll({
      'user_id': '$userId',
      'user_email': '$email'
    });
    if(url!=""){
      request.fields.addAll({
        'user_name': '$firstName',
      });
    }else{
      request.fields.addAll({
        'firstname': '$firstName',
      });
    }

    if(image!=null){
      request.files
          .add(await  http.MultipartFile('user_image',   image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: path.basename(image.path),
        contentType: MediaType('image', 'jpeg'),));
    }

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    print(request.fields);
    var str = await response.stream.bytesToString();
    print(str);
    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      return UpdateProfileResponse.fromJson(json.decode(str));
    } else {
      return null;
    }
  }else{
    Map body ={
      'user_id': '$userId',
      'firstname': '$firstName',
      'user_email': '$email'
    };
    if(url!=""){
      body['user_name'] = '$firstName';
    }else{
      body['firstname'] = '$firstName';

    }
    var request =await http.post(
        Uri.parse(
            url==""?'https://alphawizztest.tk/Deffo/api/authentication/editProfile':'https://alphawizztest.tk/Deffo/api/authentication/edithostProfile'),body:body);
    print({
      'user_id': '$userId',
      'firstname': '$firstName',
      'user_email': '$email'
    });
    var str = jsonDecode(request.body);
    print(str);
    if (request.statusCode == 200) {
      var str = jsonDecode(request.body);
      return UpdateProfileResponse.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

}

//create Property
Future<CreatePropertyModel?> createProperty(
    userId,
    title,
    number,
    email,
    address,
    type,
    contactName,
    checkIn,
    checkOut,
    typeName,
    description,
    id,
    edit,cityID) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/added_property'));
  request.fields.addAll({
    'title': '$title',
    'contact_name': '$contactName',
    'contact': '$number',
    'email': '$email',
    'address': '$address',
    'type': '$type',
    'type_name': '$typeName',
    'check_in': '$checkIn',
    'check_out': '$checkOut',
    'user_id': '$userId',
    'description': '$description',
    'city_id':cityID,
  });

  if (edit) {
    request.fields.addAll({"id": "$id"});
  }
  http.StreamedResponse response = await request.send();
  print("test"+request.fields.toString());
  print(response.statusCode);
  if (response.statusCode == 200) {
    var str = await response.stream.bytesToString();

    return CreatePropertyModel.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

//List Of property
Future<PropertyListModel?> getPropertyList(userId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/listing_property'));
  request.fields.addAll({'user_id': '$userId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var str = await response.stream.bytesToString();
    print(str);
    return PropertyListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

//Set Property Listing
Future<UpdatePropertyModel?> setPropertiesDetails(
  id,
  internet,
  others,
) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/list_of_property'));
  request.fields.addAll({'internet': internet, 'others': others, 'id': id});

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

    return UpdatePropertyModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

//search Property
Future<SearchPropertyModel?> searchProperty(type, typeName,cityId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/search_property'));
  request.fields.addAll({'type': '$type', 'type_name': '$typeName','city_id':cityId});

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    var str = await response.stream.bytesToString();

    return SearchPropertyModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}


Future propertyImage(propertyId, image) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/property_img_store'));
  request.fields.addAll({'property_id': '$propertyId'});
  request.files
      .add(await http.MultipartFile.fromPath('property_image', '$image'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

Future<SetPropertyImageModel?> setPropertyImage(propertyId, image) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/property_img_store'));
  request.fields.addAll({'property_id': '$propertyId'});
  request.files
      .add(await http.MultipartFile.fromPath('property_image', '$image'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return SetPropertyImageModel.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<PropertyImageModel?> getPropertyImage(propertyId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/property_gallery'));
  request.fields.addAll({'property_id': '$propertyId'});
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print("$str =============getPropertyImage===============");
    return PropertyImageModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<PropertyImage?> getPropertyImage1(propertyId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/property_image'));
  request.fields.addAll({'property_id': '$propertyId'});
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print("$str =============getPropertyImage===============");
    return PropertyImage.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<DeleteImageModel?> deleteImage(imageId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/delete_property_gallery'));
  request.fields.addAll({'type': '1', 'id': '$imageId'});

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return DeleteImageModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddRoomModel?> addRoom(propertyId, roomName, noOfRoom, charges, bedRoom,
    tv, roomHeater, toilet, hotWater, id) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://alphawizztest.tk/Deffo/api/authentication/room_type'));
  request.fields.addAll({
    'property_id': '$propertyId',
    'room_type_name': '$roomName',
    'no_of_room': '$noOfRoom',
    'rent_room': '$charges',
    'bedroom': '$bedRoom',
    'tv': '$tv',
    'room_heater': '$roomHeater',
    'toilet': '$toilet',
    'hot_drinking': '$hotWater',
  });
  if (id != "true") {
    request.fields.addAll({"id": "$id"});
  }
  http.StreamedResponse response = await request.send();
  print(request.fields);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return AddRoomModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<Map> getRoomByPropertyId1(propertyId) async {
  var response =await http.post(
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/listing_room'),body:{'property_id': '$propertyId'} );


  if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    return GetRoomMode.fromJson(data).toJson();
  } else {
    return Future.value();
  }
}

Future<GetRoomMode?> getRoomByPropertyId(propertyId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/listing_room'));
  request.fields.addAll({'property_id': '$propertyId'});

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetRoomMode.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<RoomDeleteModel?> deleteRoom(id) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/room_delete'));
  request.fields.addAll({'property_id': '$id'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return RoomDeleteModel.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<AddAccountModel?> addAccount(
    id, accountName, accountNo, bankName, ifsc, image) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/update_bank_detail'));
  request.fields.addAll({
    'account_name': '$accountName',
    'account_number': '$accountNo',
    'bank_name': '$bankName',
    'ifsc_code': '$ifsc',
    'id': '$id'
  });

  if (image == true) {
    request.files
        .add(await http.MultipartFile.fromPath('chaque_image', '$image'));
  }
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return AddAccountModel.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<GetTrackModel?> getTrack(userId,{city_id,start_date,end_date}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_track_detail'));

  if(userId!=""){
    request.fields.addAll({
      'user_id': '$userId',
    });
  }else{
    request.fields.addAll({
      'city_id': '$city_id',
      'start_date': '$start_date',
      'end_date': '$end_date',
    });
  }

  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(json.decode(str));
    return GetTrackModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackModel?> createTrack(
    userId,
    activityName,
    contactName,
    contactNo,
    emailId,
    address,
    dayNo,
    nightNo,
    trackStart,
    trackEnd,
    details,
    inclusion,
    exclusion,
    terms,
    rate,
    image,id,edit,cityID,start_date,end_date) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_and_trails'));
  request.fields.addAll({
    'user_id': '$userId',
    'activity_name': '$activityName',
    'contact_name': '$contactName',
    'contact_no': '$contactNo',
    'email_id': '$emailId',
    'address': '$address',
    'day_no': '$dayNo',
    'night_no': '$nightNo',
    'track_start_point': '$trackStart',
    'track_end_point': '$trackEnd',
    'details': '$details',
    'inclusion': '$inclusion',
    'exclusion': '$exclusion',
    'term_condition': '$terms',
    'rate_per_person': '$rate',
    'city_id':cityID,
    'start_date':start_date,
    'end_date':end_date,
  });
  print(image);
  if(edit){
    request.fields.addAll({'id':id});
  }
  print(request.fields);
  if(image!=null){
    request.files.add(await http.MultipartFile.fromPath('image', '$image'));
  }
  http.StreamedResponse response = await request.send();
  print(json.encode(request.fields));
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return CreateTrackModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackModel?> updateTrack(
    id,
    userId,
    contactName,
    contactNo,
    emailId,
    address,
    dayNo,
    nightNo,
    trackStart,
    trackEnd,
    details,
    inclusion,
    exclusion,
    terms,
    rate,cityID) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_and_trails'));
  request.fields.addAll({
    'id': "$id",
    'user_id': '$userId',
    'contact_name': '$contactName',
    'contact_no': '$contactNo',
    'email_id': '$emailId',
    'address': '$address',
    'day_no': '$dayNo',
    'night_no': '$nightNo',
    'track_start_point': '$trackStart',
    'track_end_point': '$trackEnd',
    'details': '$details',
    'inclusion': '$inclusion',
    'exclusion': '$exclusion',
    'term_condition': '$terms',
    'rate_per_person': '$rate',
    'city_id':cityID,
  });

  http.StreamedResponse response = await request.send();
  print(json.encode(request.fields));
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return CreateTrackModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackGeneralModel?> createTrackGeneral(
    trackId, items, addOn) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_and_trails_items'));
  request.fields
      .addAll({'track_id': '$trackId', 'items': '$items', 'add_on': '$addOn'});

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return CreateTrackGeneralModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackAccountsModel?> createTrackAccount(
    trackId, accountName, accountNo, bankName, ifscCode) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_and_trails_account'));
  request.fields.addAll({
    'track_id': '$trackId',
    'account_name': '$accountName',
    'account_no': '$accountNo',
    'bank_name': '$bankName',
    'ifsc_code': '$ifscCode'
  });
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateTrackAccountsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackDayModel?> createTrackDays(trackId, des, image) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_day_detail'));
  request.fields.addAll({'description': '$des', 'track_id': '$trackId'});
  request.files.add(await http.MultipartFile.fromPath('image', '$image'));

  http.StreamedResponse response = await request.send();
  print(request.files);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateTrackDayModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetTrackDaysModel?> getTrackDays(trackId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_trackday_detail'));
  request.fields.addAll({'track_id': '$trackId'});

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetTrackDaysModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateCycleModel?> createCycle(
    userId,
    activityName,
    contactName,
    contactNo,
    emailId,
    address,
    noOfBikes,
    brief,
    inclusion,
    exclusion,
    terms,
    image,id,edit,cityID,start_date,end_date) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://alphawizztest.tk/Deffo/api/authentication/cycling'));
  request.fields.addAll({
    'user_id': '$userId',
    'activity_name': '$activityName',
    'contact_name': '$contactName',
    'contact_no': '$contactNo',
    'email_id': '$emailId',
    'address': '$address',
    'no_of_bikes': '$noOfBikes',
    'brief_overview': '$brief',
    'inclusion': '$inclusion',
    'exclusion': '$exclusion',
    'term_condition': '$terms',
    'city_id':cityID,
    'start_date':start_date,
    'end_date':end_date,
  });
  if(edit){
    request.fields.addAll({'id':id});
  }
  print(request.fields);
  print(image);
  if(image!=null){
    request.files.add(await http.MultipartFile.fromPath('image', '$image'));
  }

  http.StreamedResponse response = await request.send();
  print(json.encode(request.fields));
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return CreateCycleModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateCycleBrandsModel?> createCycleBrands(
    cId, brandName, noOfBikes, rate, type, details) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/cycling_bikes'));
  request.fields.addAll({
    'cycling_id': '$cId',
    'brand_name': '$brandName',
    'no_of_bike': '$noOfBikes',
    'rate': '$rate',
    'type': '$type',
    'details': '$details'
  });

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateCycleBrandsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCycleBrandsModel?> getCycleBrands(cycleId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_cyclingbikes'));
  request.fields.addAll({'cycling_id': "$cycleId"});

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetCycleBrandsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackAccountsModel?> createCycleAccount(
    trackId, accountName, accountNo, bankName, ifscCode) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_and_trails_account'));
  request.fields.addAll({
    'track_id': '$trackId',
    'account_name': '$accountName',
    'account_no': '$accountNo',
    'bank_name': '$bankName',
    'ifsc_code': '$ifscCode'
  });
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateTrackAccountsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateFestivalDetailModel?> createFestivalDetail(
    userId,
    activityName,
    contactName,
    number,
    email,
    address,
    noOfDays,
    brief,
    inclusion,
    exclusion,
    terms,
    rate,id,edit,cityID,start_date,end_date) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/festival_track_detail'));
  request.fields.addAll({
    'user_id': '$userId',
    'activity_name': '$activityName',
    'contact_name': '$contactName',
    'contact_no': '$number',
    'email_id': '$email',
    'address': '$address',
    'no_of_day': '$noOfDays',
    'brief_overview': '$brief',
    'inclusion': '$inclusion',
    'exclusion': '$exclusion',
    'term_condition': '$terms',
    'rent_per_person': '$rate',
    'city_id':cityID,
    'start_date':start_date,
    'end_date':end_date,
  });
  if(edit){
    request.fields.addAll({'id':id});
  }
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateFestivalDetailModel.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<CreateFestivalThingsModel?> createFestivalThings(fesId, things) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/festival_things_carry'));
  request.fields.addAll({'things_carry': '$things', 'id': '$fesId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateFestivalThingsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetFestivalDaysModel?> getFestivalDays(fesId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_festivalday_track'));
  request.fields.addAll({'festival_id': '$fesId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetFestivalDaysModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddFestivalDaysModel?> addFestivalDays(fesId, dayDetails) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/track_festivalday_detail'));
  request.fields.addAll({'festival_id': '$fesId', 'day_detail': '$dayDetails'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return AddFestivalDaysModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddFestivalAccountModel?> addFestivalAccount(
    accountName, accountNo, bankName, ifscCode, fesID) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/festival_account'));
  request.fields.addAll({
    'account_name': '$accountName',
    'account_no': '$accountNo',
    'bank_name': '$bankName',
    'ifsc_code': '$ifscCode',
    'festival_id': '$fesID'
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var str = await response.stream.bytesToString();
    return AddFestivalAccountModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCyclingListModel?> getCycleList(userId,{city_id,start_date,end_date}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_cycling'));
  if(userId!=""){
    request.fields.addAll({
      'user_id': '$userId',
    });
  }else{
    request.fields.addAll({
      'city_id': '$city_id',
      'start_date': '$start_date',
      'end_date': '$end_date',
    });
  }

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    print(json.decode(str));
    return GetCyclingListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetFestivalListModel?> getFestivalList(userId,{city_id,start_date,end_date}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_festival_track'));
  if(userId!=""){
    request.fields.addAll({
      'user_id': '$userId',
    });
  }else{
    request.fields.addAll({
      'city_id': '$city_id',
      'start_date': '$start_date',
      'end_date': '$end_date',
    });
  }

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(json.decode(str));
    return GetFestivalListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTourDetailsModel?> createTour(userId, activityName, contactName,
    contactNo, email, address, breif, terms, things, rate,id,edit,cityID,start_date,end_date) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/tour_detail'));
  request.fields.addAll({

    'user_id': '$userId',
    'activity_name': '$activityName',
    'contact_name': '$contactName',
    'contact_no': '$contactNo',
    'email_id': '$email',
    'address': '$address',
    'brief_overview': '$breif',
    'term_condition': '$terms',
    'things_carry': '$things',
    'rate_per_person': '$rate',
    'city_id':cityID,
    'start_date':start_date,
    'end_date':end_date,
  });
  if(edit){
    request.fields.addAll({'id':id});
  }
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(json.decode(str));
    return CreateTourDetailsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateTrackAccountsModel?> tourAccount(
    tourId, accountName, accountNo, bankName, ifscCode) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/tour_account'));
  request.fields.addAll({
    'id': '$tourId',
    'account_name': '$accountName',
    'account_no': '$accountNo',
    'bank_name': '$bankName',
    'ifsc_code': '$ifscCode'
  });

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateTrackAccountsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetTourListModel?> getTourList(userId,{city_id,start_date,end_date}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/authentication/get_tour_detail'));
  if(userId!=""){
    request.fields.addAll({
      'user_id': '$userId',
    });
  }else{
    request.fields.addAll({
      'city_id': '$city_id',
      'start_date': '$start_date',
      'end_date': '$end_date',
    });
  }

  http.StreamedResponse response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(request.fields);
    print(str);
    print(json.decode(str));
    return GetTourListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<BookingModal?> hotelBooking(
    userId,
    hostId,
    hotelCat,
    hotelSubCat,
    hotelCatId,
    hotelSubCatId,
    checkIn,
    checkOut,
    checkInTime,
    checkOutTime,
    noOfGuest,
    amount,
    payment,name,email,phone,propertyId,room_id,no_of_room) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/Authentication/hotel_booking'));
  request.fields.addAll({
    'user_id': '$userId',
    'host_id': '$hostId',
    'hotel_cat': '$hotelCat',
    'hotel_sub_cat': '$hotelSubCat',
    'hotel_cat_id': '$hotelCatId',
    'hotel_sub_cat_id': '$hotelSubCatId',
    'check_in': '$checkIn',
    'check_out': '$checkOut',
    'check_in_date': '$checkIn',
    'check_out_date': '$checkOut',
    'check_in_time': '$checkInTime',
    'check_out_time': '$checkOutTime',
    'no_of_guest': '$noOfGuest',
    'amount': '$amount',
    'payment': '$payment',
    'name': '$name',
    'email': '$email',
    'phone': '$phone',
    'property_id':propertyId,
    'no_of_room':no_of_room,
    'room_id':room_id,
  });

  http.StreamedResponse response = await request.send();
 print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return BookingModal.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<BookingModal?> trackBooking(hostId, userId, trackId, trackName,
    customerName, email, phone, date, amount, payment, noOfGuest) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/Authentication/track_and_detail_booking'));
  request.fields.addAll({
    'host_id': '$hostId',
    'user_id': '$userId',
    'track_id': '$trackId',
    'track_name': '$trackName',
    'customer_name': '$customerName',
    'email': '$email',
    'phone': '$phone',
    'date': '$date',
    'amount': '$amount',
    'payment': '$payment',
    'no_of_guest': '$noOfGuest'
  });

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return BookingModal.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<BookingModal?> cycleBooking(
    userId,
    hostId,
    cycleId,
    cycleName,
    bikeId,
    bikeName,
    customerName,
    email,
    phone,
    date,
    amount,
    payment,
    noOfGuest) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/Authentication/cycle_booking'));
  request.fields.addAll({
    'user_id': '$userId',
    'host_id': '$hostId',
    'cycle_id': '$cycleId',
    'cycle_name': '$cycleName',
    'bike_id': '$bikeId',
    'bike_name': '$bikeName',
    'customer_name': '$customerName',
    'email': '$email',
    'phone': '$phone',
    'date': '$date',
    'amount': '$amount',
    'payment': '$payment',
    'no_of_guest': '$noOfGuest'
  });

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return BookingModal.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<BookingModal?> festivalBooking(userId, hostId, festivalId, festivalName,
    customerName, email, phone, date, amount, payment, noOfGuest) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/Authentication/festival_booking'));
  request.fields.addAll({
    'user_id': '$userId',
    'host_id': '$hostId',
    'festival_id': '$festivalId',
    'festival_name': '$festivalName',
    'customer_name': '$customerName',
    'email': '$email',
    'phone': '$phone',
    'date': '$date',
    'amount': '$amount',
    'payment': '$payment',
    'no_of_guest': '$noOfGuest'
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return BookingModal.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}

Future<BookingModal?> tourBooking(userId, hostId, tourId, tourName,
    customerName, email, phone, date, amount, payment, noOfGuest) async {
  var headers = {'Cookie': 'ci_session=1a759l3oasem56cd14126uv5bc5q74sv'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://alphawizztest.tk/Deffo/api/Authentication/tour_booking'));
  request.fields.addAll({
    'user_id': '$userId',
    'host_id': '$hostId',
    'tour_id': '$tourId',
    'tour_name': '$tourName',
    'customer_name': '$customerName',
    'email': '$email',
    'phone': '$phone',
    'date': '$date',
    'amount': '$amount',
    'payment': '$payment',
    'no_of_guest': '$noOfGuest'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(request.fields);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return BookingModal.fromJson(json.decode(str));
  } else {
    print(response.reasonPhrase);
  }
}
