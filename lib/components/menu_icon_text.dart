import 'package:flutter/material.dart';

class MenuIconText extends StatelessWidget {
  final String image;
  final String text;
  final double padding;
  final VoidCallback? callback;

  const MenuIconText({
    super.key,
    required this.image,
    required this.text,
    this.padding = 20,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: callback,
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
