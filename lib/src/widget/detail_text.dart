import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String title;
  final String detail;

  const DetailText(this.title, this.detail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: "$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: "$detail")
      ]),
      style: TextStyle(fontSize: 20),
    );
  }
}
