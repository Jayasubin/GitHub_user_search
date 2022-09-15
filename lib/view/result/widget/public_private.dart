import 'package:flutter/material.dart';

class PublicPrivate extends StatelessWidget {
  final bool isPrivate;
  const PublicPrivate({Key? key, required this.isPrivate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isPrivate ? Colors.redAccent : Colors.greenAccent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        isPrivate ? 'Private' : 'Public',
        style: const TextStyle(fontSize: 12.0),
      ),
    );
  }
}
