import 'package:flutter/material.dart';

class BotaoIcone extends StatelessWidget {
  final IconData icone;
  final Color cor;
  final double padding;

  const BotaoIcone({
    Key? key,
    required this.icone,
    required this.cor,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Icon(
              icone,
              color: cor,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}