import 'package:flutter/material.dart';

class MenuIconText extends StatelessWidget {
  final String image;
  final String text;
  final double padding;

  const MenuIconText(
      {super.key, required this.image, required this.text, this.padding = 20});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
