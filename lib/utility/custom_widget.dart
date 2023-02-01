import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final url;

  const CustomImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade300,
          child: Image.asset("assets/introduction_animation/logo.png" , color: Colors.grey, scale: 2,)),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}