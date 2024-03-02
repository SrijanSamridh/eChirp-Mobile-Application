import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String Image;
  const CustomTile({super.key, required this.title, required this.subTitle, required this.Image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height / 8,
        width: size.width / 1.09,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(18)),
        child: Center(
            child: ListTile(
          leading: CircleAvatar(),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing: Icon(Icons.add),
        )));
  }
}
