import 'package:flutter/material.dart';

///an oval image which has a default size of 40 and an optional image parameter
class OvalPicture extends StatelessWidget {
  const OvalPicture({Key? key, this.image, this.size = 50}) : super(key: key);
  final double size;
  final Image? image;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.grey,
        height: size,
        width: size,
        child: image ?? Container(),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.text, {Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
