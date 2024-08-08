import 'package:flutter/material.dart';

class DeafaultElevetedBotton extends StatelessWidget {
  const DeafaultElevetedBotton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 52),
      ),
      child: Text(label),
      // style: ElevatedButton.styleFrom(
      //   fixedSize: const Size(
      //     255,
      //     52,
      //   ),
      // ),
    );
  }
}
