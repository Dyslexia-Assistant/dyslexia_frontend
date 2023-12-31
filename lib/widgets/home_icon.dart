import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget{
  final Function func;
  final Color iconColor;
  final Color backgroundColor;
  final IconData icon;
  final String title;

  const HomeIcon({super.key, required this.func, required this.iconColor, required this.backgroundColor, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24.0), // Atur radius sesuai keinginan
          ),
          child: IconButton(
            iconSize: 32,
            icon: Icon(
              icon,
              color: iconColor,
            ),
            onPressed: () {
              // Lakukan sesuatu ketika tombol ditekan
              func();
            },
          ),
        ),
        SizedBox(height: 8,),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black),)
      ],
    );
  }
}