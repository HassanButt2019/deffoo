class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/ecostay/Homestay.png',
      titleTxt: 'Homestay',
      kacl: 525,
      meals: <String>['', '', ''],
      startColor: '#FA7D82',
      endColor: '#ff5c21',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Guest houses.png',
      titleTxt: 'Guest houses',
      kacl: 602,
      meals: <String>['', '', ''],
      startColor: '#738AE6',
      endColor: '#3033db',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Eco resorts.png',
      titleTxt: 'Eco resorts',
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#FE95B6',
      endColor: '#fa2565',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Cottages..png',
      titleTxt: 'Cottages',
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Farm Houses.png',
      titleTxt: 'Farm houses',
      kacl: 525,
      meals: <String>['', '', ''],
      startColor: '#FA7D82',
      endColor: '#fa652f',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Boutique hotels.png',
      titleTxt: 'Boutique hotels',
      kacl: 602,
      meals: <String>['', '', ''],
      startColor: '#738AE6',
      endColor: '#2a2ddb',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Tents.png',
      titleTxt: 'Tents',
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#FE95B6',
      endColor: '#fa2d6a',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Tree houses.png',
      titleTxt: 'Tree houses',
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    MealsListData(
      imagePath: 'assets/ecostay/Flats.png',
      titleTxt: 'Flats',
      kacl: 0,
      meals: <String>['', ''],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
