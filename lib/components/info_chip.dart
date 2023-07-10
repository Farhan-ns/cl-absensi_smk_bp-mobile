import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  // final String image;
  final String name;
  final String date;
  final Widget child;
  final ImageProvider imageProvider;

  const InfoChip({
    super.key,
    // required this.image,
    required this.name,
    required this.date,
    required this.child,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: imageProvider,
          radius: 27,
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          flex: 2,
          child: child,
        )
      ],
    );
  }
}
