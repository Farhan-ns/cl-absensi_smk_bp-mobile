import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  // MyAppBar({super.key, required String title}) : super(title: Text(title));
  MyAppBar({super.key})
      : super(
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.notifications_none_outlined, size: 32),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/icons/logo-bp.png',
                fit: BoxFit.contain,
                height: 56,
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/icons/logo-yayasan.png',
                fit: BoxFit.contain,
                height: 54,
              )
            ],
          ),
        );
}
