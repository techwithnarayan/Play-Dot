import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btnName;
  final TextStyle? btnnameStyle;
  final Color? color;
  final double? borderRadius;
  final Color? tapColor;
  final Color? splashColor;
  final Color? hoverColor;
  final void Function()? onTap;

  const AppButton({
    Key? key,
    required this.btnName,
    this.btnnameStyle,
    this.color = Colors.red,
    this.borderRadius = 10,
    this.tapColor = Colors.black,
    this.splashColor = Colors.grey,
    this.hoverColor = Colors.amber,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius!)),
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius!),
          splashColor: splashColor,
          hoverColor: hoverColor,
          highlightColor: tapColor,
          onTap: () {
            onTap!();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              btnName,
              style: btnnameStyle,
            ),
          ),
        ),
      ),
    );
  }
}
