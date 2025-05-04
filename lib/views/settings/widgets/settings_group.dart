import 'package:flutter/cupertino.dart';

class SettingsGroup extends StatelessWidget {
  SettingsGroup(
      {super.key,
      required this.settingsGroupTitle,
      required this.items,
      required this.backgroundColor});
  String? settingsGroupTitle;
  List<Widget> items = [];
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              settingsGroupTitle!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: items,
          )
        ],
      ),
    );
  }
}
