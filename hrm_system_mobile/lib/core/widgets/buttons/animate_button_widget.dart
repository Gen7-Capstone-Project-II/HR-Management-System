import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';

/*
 * AnimatedButton with scale animation
 */
class AnimatedButton extends StatefulWidget {
  final String title;
  final double fontSize;
  final dynamic onTap;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final E_ANIMATED_BUTTON_STYLE eAnimatedButtonStyle;
  final String? assetImage;
  final double? assetImageSize;

  const AnimatedButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.fontSize = 14.0,
    this.eAnimatedButtonStyle = E_ANIMATED_BUTTON_STYLE.ROW,
    this.padding,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.assetImage,
    this.assetImageSize,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  double? _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale!,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 99),
        border: Border.all(color: widget.borderColor ?? Colors.white),
        color: widget.backgroundColor ?? Colors.green,
      ),
      child: _buildContent());

  Widget _buildContent() {
    Widget animatedButton = const SizedBox.shrink();
    if (widget.eAnimatedButtonStyle == E_ANIMATED_BUTTON_STYLE.ROW) {
      animatedButton = widget.icon != null
          ? RichText(
              text: TextSpan(
                children: [
                  widget.assetImage != null ? WidgetSpan(child: Image.asset(widget.assetImage!, width: widget.assetImageSize ?? 30)) : WidgetSpan(child: Icon(widget.icon, color: widget.iconColor ?? Colors.white, size: widget.iconSize ?? 18)),
                  const WidgetSpan(child: SizedBox(width: 3)),
                  TextSpan(text: widget.title, style: TextStyle(color: widget.titleColor ?? Colors.white)),
                ],
              ),
            )
          : Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor ?? Colors.white,
              ),
            );
    } else {
      animatedButton = Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.assetImage != null
              ? Image.asset(
                  widget.assetImage!,
                  width: widget.assetImageSize ?? 30,
                )
              : Icon(widget.icon, color: widget.iconColor ?? Colors.white, size: widget.iconSize ?? 18),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor ?? Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: widget.fontSize,
              ),
              textAlign: TextAlign.start,
            ),
          )
        ],
      );
    }
    return animatedButton;
  }
}
