import 'package:flutter/material.dart';

class CircleAvatarButton extends StatelessWidget {
  final String url;
  final VoidCallback onTap;

  const CircleAvatarButton({Key? key, required this.url, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: CircleAvatar(backgroundImage: NetworkImage(url)), onTap: onTap);
  }
}
