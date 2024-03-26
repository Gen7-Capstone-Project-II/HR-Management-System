import 'package:flutter/material.dart';

/*
 * CustomButtonWidget
 */
class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;
  final Color? buttonColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? margin;
  final TextAlign textAlign;
  final Widget? trailing;
  final double? fontSize;

  const CustomButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.buttonColor = Colors.lightBlue,
      this.textColor = Colors.white,
      this.borderRadius = 4.0,
      this.margin = const EdgeInsets.only(top: 20),
      this.textAlign = TextAlign.center,
      this.fontSize = 16,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            width: MediaQuery.of(context).size.width,
            child: trailing != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(buttonText, style: TextStyle(color: textColor), textAlign: textAlign),
                      ),
                      Expanded(flex: 1, child: trailing!)
                    ],
                  )
                : Text(buttonText, style: TextStyle(color: textColor, fontSize: fontSize), textAlign: textAlign),
          ),
        ),
      ),
    );
  }
}
