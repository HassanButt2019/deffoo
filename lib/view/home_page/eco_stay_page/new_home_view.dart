import 'package:deffo/Screen/Slider/home_slider.dart';
import 'package:flutter/material.dart';

class getMainListViewUi extends StatelessWidget {
  const getMainListViewUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // controller: scrollController,

      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: 5,
            ),
            HomePageSliderView()
          ],
        );
      },
    );
  }
}
