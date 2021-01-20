import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final double borderRadius;
  final Function onChange;
  final Function onSave;

  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  CustomTextFieldWidget({
    Key key,
    @required this.hintText,
    @required this.obscureText,
    @required this.textInputType,
    @required this.controller,
    this.borderRadius = 30,
    this.inputFormatters = const [],
    this.maxLength,
    this.onChange,
    this.onSave,
  }) : super(key: key);

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xfff0eded),
        borderRadius: BorderRadius.circular(6),
        border: new Border.all(
          color: Colors.white60,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.textInputType,
                obscureText: widget.obscureText,
                controller: widget.controller,
                onChanged: widget.onChange,
                onSaved: widget.onSave,
                maxLength: widget.maxLength,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Color(
                    0xFF323232,
                  ),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '${widget.hintText}',
                  hintStyle: TextStyle(
                    color: Color(0xff323232),
                  ),
                  focusColor: Color(0xFFE5FFEA),
                  // focusedBorder: InputBorder(borderSide: ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
