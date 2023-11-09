import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contact us',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            'xyz@gmail.com',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          Text(
            'Follow  us',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            'Facebook | Twitter | LinkedIn',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
