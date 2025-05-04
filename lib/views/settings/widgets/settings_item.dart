import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem(
      {super.key,
      required this.onTap,
      required this.icons,
      required this.title,
      required this.subtitle,
      required this.iconColor});
  Function()? onTap;
  IconData? icons;
  String? title;
  String? subtitle;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: iconColor!.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icons,
            color: iconColor,
          ),
        ),
      ),
      title: Text(title!),
      subtitle: Text(subtitle!),
    );
  }
}
