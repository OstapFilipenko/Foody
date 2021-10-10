import 'package:flutter/material.dart';
import 'package:foody/flutter_flow/flutter_flow_theme.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    Key key,
    @required this.textController,
    @required this.hintText,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: false,
      decoration: InputDecoration(
        labelText: this.hintText,
        labelStyle: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
        hintText: this.hintText,
        hintStyle: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      ),
      style: FlutterFlowTheme.bodyText1.override(
        fontFamily: 'Poppins',
        color: Colors.black,
      ),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val.isEmpty) {
          return 'This field is required';
        }

        return null;
      },
    );
  }
}
