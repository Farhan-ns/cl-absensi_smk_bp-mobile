import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  final Widget child;

  const InfoChip({
    super.key,
    required this.image,
    required this.name,
    required this.date,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        Column(
          children: [
            Text(name),
            Text(date),
          ],
        ),
        child
      ],
    );
  }
}
