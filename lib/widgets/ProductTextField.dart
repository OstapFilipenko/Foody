import 'package:flutter/material.dart';
import 'package:foody/flutter_flow/flutter_flow_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:foody/translations/locale_keys.g.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    Key key,
    @required this.textController,
    @required this.hintText,
    @required this.number,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final bool number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: textController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: this.hintText,
              labelStyle: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            keyboardType:
                this.number ? TextInputType.number : TextInputType.text,
            validator: (val) {
              if (val.isEmpty) {
                return LocaleKeys.required.tr();
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
