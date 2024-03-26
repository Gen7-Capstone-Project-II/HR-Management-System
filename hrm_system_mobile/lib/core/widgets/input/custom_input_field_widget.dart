import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:human_resource_management_system/core/consts/color_const.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';

/*
 * CustomInputFieldWidget
 */
class CustomInputFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final E_KEYBOARD_TYPE? eKeyboardType;
  final E_TEXTFIELD_MODE eTextfiedlMode;
  final bool obscureText;
  final bool autoFocus;
  final bool enable;
  final int maxLines;
  final IconData? prefixIcon;
  final double? prefixIconSize;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final Function? suffixIconTap;
  final Function(String)? validation;
  final Function(String)? getText;
  final Color fillColor;
  final double? fontSize;
  final Color? borderColor;
  final double? elevation;

  const CustomInputFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.prefixIconSize = 18,
    this.suffixIcon,
    this.suffixIconSize = 18,
    this.suffixIconTap,
    this.eKeyboardType = E_KEYBOARD_TYPE.TEXT,
    this.eTextfiedlMode = E_TEXTFIELD_MODE.LABEL_TEXT,
    this.autoFocus = false,
    this.obscureText = false,
    this.enable = true,
    this.maxLines = 1,
    this.validation,
    this.getText,
    this.fillColor = ColorConst.GREY_50,
    this.fontSize = 16,
    this.borderColor = ColorConst.GREY_50,
    this.elevation = 0,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomInputFieldWidgetState createState() => _CustomInputFieldWidgetState();
}

class _CustomInputFieldWidgetState extends State<CustomInputFieldWidget> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  bool checkTextfieldFocus() {
    bool hasFocus = false;
    if (focusNode.hasFocus) {
      hasFocus = true;
    }
    return hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.eTextfiedlMode == E_TEXTFIELD_MODE.LABEL_TEXT) {
      return buildTextField();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.label != null,
            child: Text(
              widget.label ?? "",
              style: TextStyle(fontSize: widget.fontSize),
            ),
          ),
          Visibility(visible: widget.label != null, child: const SizedBox(height: 8)),
          buildTextField(),
        ],
      );
    }
  }

  Widget buildTextField() {
    if (widget.controller != null) {
      return Material(
        elevation: widget.elevation!,
        child: TextFormField(
          focusNode: focusNode,
          enabled: widget.enable,
          obscureText: widget.obscureText,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          maxLines: widget.maxLines,
          style: TextStyle(fontSize: widget.fontSize),
          decoration: inputDecoration(),
          keyboardType: keyBoardType(),
          inputFormatters: inputFormatters(),
          validator: (text) {
            if (widget.validation != null) {
              return widget.validation!(text!);
            }
            return null;
          },
        ),
      );
    }

    return Material(
      elevation: widget.elevation!,
      child: TextFormField(
        focusNode: focusNode,
        enabled: widget.enable,
        obscureText: widget.obscureText,
        autofocus: widget.autoFocus,
        maxLines: widget.maxLines,
        style: TextStyle(fontSize: widget.fontSize),
        decoration: inputDecoration(),
        keyboardType: keyBoardType(),
        inputFormatters: inputFormatters(),
        onChanged: (text) {
          if (widget.getText != null) {
            setState(() {
              widget.getText!(text);
            });
          }
        },
        validator: (text) {
          if (widget.validation != null) {
            return widget.validation!(text!);
          }
          return null;
        },
      ),
    );
  }

  TextInputType keyBoardType() {
    switch (widget.eKeyboardType) {
      case E_KEYBOARD_TYPE.TEXT:
        return TextInputType.text;
      case E_KEYBOARD_TYPE.NUMBER:
        return TextInputType.number;
      case E_KEYBOARD_TYPE.EMAIL:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? inputFormatters() {
    switch (widget.eKeyboardType) {
      case E_KEYBOARD_TYPE.TEXT:
        return null;
      case E_KEYBOARD_TYPE.NUMBER:
        return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
      case E_KEYBOARD_TYPE.EMAIL:
        return null;
      default:
        return null;
    }
  }

  Widget prefixIcon() {
    return Builder(builder: (context) {
      Widget _prefix = const SizedBox.shrink();
      if (widget.prefixIcon != null) {
        _prefix = Padding(
          padding: const EdgeInsets.only(right: 7.0),
          child: Icon(widget.prefixIcon, size: widget.prefixIconSize),
        );
      }
      return _prefix;
    });
  }

  Widget suffixIcon() {
    return GestureDetector(
      onTap: () {
        if (widget.suffixIconTap != null) {
          widget.suffixIconTap!();
        }
      },
      child: Builder(
        builder: (context) {
          Widget _suffix = const SizedBox.shrink();
          if (widget.suffixIcon != null) {
            _suffix = Icon(widget.suffixIcon, size: widget.suffixIconSize);
          }
          return _suffix;
        },
      ),
    );
  }

  InputDecoration inputDecoration() {
    if (widget.eTextfiedlMode == E_TEXTFIELD_MODE.LABEL_TEXT) {
      return InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.label,
        hintStyle: TextStyle(fontSize: widget.fontSize),
        border: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!)),
        prefixIcon: widget.prefixIcon != null ? prefixIcon() : null,
        suffixIcon: widget.suffixIcon != null ? suffixIcon() : null,
      );
    } else {
      return InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: widget.fontSize),
        border: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!)),
        prefixIcon: widget.prefixIcon != null ? prefixIcon() : null,
        suffixIcon: widget.suffixIcon != null ? suffixIcon() : null,
      );
    }
  }
}
