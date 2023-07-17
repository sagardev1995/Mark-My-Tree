// ignore_for_file: use_key_in_widget_constructors
/*
This is the class for the custom appBar that is displayed on top of every screen.
*/
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF41AA5F),
      toolbarHeight: 100,
      title: Row(
        children: [
          Image.asset(
            'assets/images/appbar-img-modified.png',
            width: 50,
            height: 70,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '           अंकन आदेश आवेदन पोर्टल',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                SizedBox(height: 2),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '   MARKING ORDER APPLICATION',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            'assets/images/login-img.png',
            width: 60,
            height: 60,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 30);
}
