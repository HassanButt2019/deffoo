import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/bottom/unselect.png',
      selectedImagePath: 'assets/bottom/Group 52949.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/Group 46909.png',
      selectedImagePath: 'assets/bottom/Group 52950.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/Path 102810.png',
      selectedImagePath: 'assets/bottom/Group 52951.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/Path 102852.png',
      selectedImagePath: 'assets/bottom/Group 52952.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
