import 'package:flutter/material.dart';
import 'package:global_stream/utils/constants.dart';

class GlobalTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
 final bool obscure;

  const GlobalTextField(
      {Key? key,
      required this.textTheme,
      required this.text,
      required this.hintText,
      this.validator,
        this.obscure = false,
      this.onSaved})
      : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: textTheme.bodyText1,
        ),
        TextFormField(
          cursorColor: kOrangeColor,
          style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal),
          validator: validator,
          onSaved: onSaved,
          obscureText: obscure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodyText1!.copyWith(color: kOffWhite),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kColorWhite, width: 4),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kOrangeDeep, width: 4),
            ),
          ),
        )
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.textTheme,
      this.onTap,
      this.color,
      this.text,
      this.color2})
      : super(key: key);

  final TextTheme textTheme;
  final Function()? onTap;
  final Color? color;
  final String? text;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: kColorWhite, width: 2),
        ),
        child: Text(text!, style: textTheme.bodyText2,),
      ),
    );
  }
}
