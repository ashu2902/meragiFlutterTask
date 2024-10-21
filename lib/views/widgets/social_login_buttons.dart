import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _socialButton('Facebook'),
        _socialButton('Linked In'),
        _socialButton('Google'),
      ],
    );
  }

  Widget _socialButton(String text) {
    return TextButton(
      onPressed: () {},
      child: AutoSizeText(
        text,
        style: const TextStyle(
          color: Color(0xFF355B3E),
          fontSize: 14,
        ),
        maxLines: 1,
      ),
    );
  }
}
