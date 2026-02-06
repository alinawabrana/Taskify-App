import 'package:flutter/material.dart';

class CircularImageContainer extends StatelessWidget {
  const CircularImageContainer({
    super.key,
    required this.imageUrl,
    this.width = 50,
    this.height = 50,
    this.radius = 20,
  });

  final String imageUrl;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage(String imageUrl) {
      return imageUrl.startsWith('http') || imageUrl.startsWith('https');
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white70,
        radius: radius,
        backgroundImage:
            isNetworkImage(imageUrl)
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl),
      ),
    );
  }
}
