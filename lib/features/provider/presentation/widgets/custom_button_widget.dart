import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomButtonWidget extends StatefulWidget {
  final Function onTap;
  final String buttonText;
  CustomButtonWidget({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CustomButtonWidgetState createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: widget.onTap != null
              ? Theme.of(context).primaryColor
              : Color.fromRGBO(7, 45, 114, 0.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            '${widget.buttonText}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
  }
}
