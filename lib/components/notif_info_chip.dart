import 'package:flutter/material.dart';

class NotifInfoChip extends StatelessWidget {
  // final String image;
  final String name;
  final String date;
  final String text;
  final ImageProvider imageProvider;

  const NotifInfoChip({
    super.key,
    // required this.image,
    required this.name,
    required this.date,
    required this.text,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
